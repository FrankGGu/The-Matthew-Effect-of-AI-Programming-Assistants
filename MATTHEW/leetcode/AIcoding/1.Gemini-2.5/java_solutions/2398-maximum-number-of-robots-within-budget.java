import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int maximumRobots(int[] chargeTimes, int[] runningCosts, long budget) {
        int n = chargeTimes.length;
        if (n == 0) {
            return 0;
        }

        int maxLen = 0;
        int i = 0; 
        long currentRunningCostSum = 0; 
        Deque<Integer> dq = new ArrayDeque<>(); 

        for (int j = 0; j < n; j++) { 
            while (!dq.isEmpty() && chargeTimes[dq.peekLast()] <= chargeTimes[j]) {
                dq.removeLast();
            }
            dq.addLast(j);

            currentRunningCostSum += runningCosts[j];

            int k = j - i + 1;
            long currentMaxChargeTime = chargeTimes[dq.peekFirst()];
            long currentCost = currentMaxChargeTime + currentRunningCostSum * k;

            while (currentCost > budget) {
                currentRunningCostSum -= runningCosts[i];

                if (dq.peekFirst() == i) {
                    dq.removeFirst();
                }

                i++;

                if (i > j) { 
                    break; 
                }

                k = j - i + 1;
                currentMaxChargeTime = chargeTimes[dq.peekFirst()];
                currentCost = currentMaxChargeTime + currentRunningCostSum * k;
            }

            maxLen = Math.max(maxLen, j - i + 1);
        }

        return maxLen;
    }
}