import java.util.Arrays;

class Solution {
    private int[][] events;
    private int n;
    private int[][] memo;

    public int maxValue(int[][] events, int k) {
        this.events = events;
        this.n = events.length;

        Arrays.sort(events, (a, b) -> a[0] - b[0]);

        memo = new int[n][k + 1];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }

        return solve(0, k);
    }

    private int solve(int idx, int k_left) {
        if (k_left == 0 || idx == n) {
            return 0;
        }
        if (memo[idx][k_left] != -1) {
            return memo[idx][k_left];
        }

        // Option 1: Skip current event
        int maxVal = solve(idx + 1, k_left);

        // Option 2: Attend current event
        // Find the next event that starts after current event ends
        int nextIdx = findNext(idx, events[idx][1]);
        maxVal = Math.max(maxVal, events[idx][2] + solve(nextIdx, k_left - 1));

        memo[idx][k_left] = maxVal;
        return maxVal;
    }

    private int findNext(int currentEventIdx, int targetEndTime) {
        int low = currentEventIdx + 1;
        int high = n - 1;
        int ans = n; 

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (events[mid][0] > targetEndTime) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
}