import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int boxDelivering(int[][] boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.length;

        int[] dp = new int[n + 1];
        long[] prefixWeight = new long[n + 1];
        int[] sPortsChange = new int[n + 1];

        prefixWeight[0] = 0;
        sPortsChange[0] = 0;
        // sPortsChange[k] stores the number of times the port changes from boxes[0] to boxes[k-1].
        // Specifically, it's sum(1 if boxes[x][0] != boxes[x-1][0] for x from 1 to k-1).
        // sPortsChange[1] is 0 as there's no box[0-1] to compare with box[0].
        sPortsChange[1] = 0; 

        for (int k = 1; k <= n; k++) {
            prefixWeight[k] = prefixWeight[k - 1] + boxes[k - 1][1];
            sPortsChange[k] = sPortsChange[k - 1];
            if (k >= 2 && boxes[k - 1][0] != boxes[k - 2][0]) {
                sPortsChange[k]++;
            }
        }

        Deque<Integer> dq = new LinkedList<>();
        dq.addLast(0); // Base case: dp[0] = 0, representing no boxes delivered yet.

        int leftPtr = 0; // Tracks the minimum 'j' that satisfies the maxWeight constraint

        for (int i = 1; i <= n; i++) {
            // Adjust leftPtr to satisfy the maxWeight constraint for the current window [leftPtr, i-1]
            // prefixWeight[i] - prefixWeight[leftPtr] <= maxWeight
            // This implies prefixWeight[leftPtr] >= prefixWeight[i] - maxWeight
            while (leftPtr < i && prefixWeight[i] - prefixWeight[leftPtr] > maxWeight) {
                leftPtr++;
            }

            // Remove indices from the front of the deque that are no longer valid
            // 1. Due to maxWeight constraint: j must be >= leftPtr
            // 2. Due to maxBoxes constraint: i - j <= maxBoxes => j >= i - maxBoxes
            while (!dq.isEmpty() && dq.peekFirst() < leftPtr) {
                dq.removeFirst();
            }
            while (!dq.isEmpty() && dq.peekFirst() < i - maxBoxes) {
                dq.removeFirst();
            }

            // Calculate dp[i] using the optimal 'j' from the front of the deque
            // The cost of a trip delivering boxes from j to i-1 is:
            // 1 (for the trip itself) + (1 + number of port changes from j+1 to i-1)
            // = 2 + (sPortsChange[i] - sPortsChange[j+1])
            // So, dp[i] = dp[j] + 2 + sPortsChange[i] - sPortsChange[j+1]
            // Rearranging: dp[i] = (2 + sPortsChange[i]) + (dp[j] - sPortsChange[j+1])
            dp[i] = dp[dq.peekFirst()] + 2 + sPortsChange[i] - sPortsChange[dq.peekFirst() + 1];

            // Add 'i' to the back of the deque, maintaining the monotonic property
            // We want to minimize (dp[j] - sPortsChange[j+1])
            // So, remove 'j' from back if (dp[j] - sPortsChange[j+1]) is worse than or equal to (dp[i] - sPortsChange[i+1])
            while (!dq.isEmpty() && 
                   (dp[dq.peekLast()] - sPortsChange[dq.peekLast() + 1]) >= (dp[i] - sPortsChange[i + 1])) {
                dq.removeLast();
            }
            dq.addLast(i);
        }

        return dp[n];
    }
}