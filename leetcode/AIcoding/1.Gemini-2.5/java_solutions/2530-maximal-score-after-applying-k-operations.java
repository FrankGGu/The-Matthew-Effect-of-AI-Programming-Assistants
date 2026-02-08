import java.util.PriorityQueue;

class Solution {
    public int maxResult(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];

        // dp[i] stores the maximum score to reach index i.
        // We need to find max(dp[j]) for j in [i-k, i-1].
        // A max-priority queue will store (score, index) pairs
        // and help us efficiently find the maximum score in the sliding window.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);

        // Base case: To reach index 0, the score is just nums[0].
        dp[0] = nums[0];
        pq.add(new int[]{dp[0], 0}); // Add (score, index) to the priority queue

        for (int i = 1; i < n; i++) {
            // Remove elements from the priority queue whose indices are out of the k-window.
            // The valid window for jumps to 'i' is from 'i-k' to 'i-1'.
            while (pq.peek()[1] < i - k) {
                pq.poll();
            }

            // The maximum score to reach 'i' is nums[i] plus the maximum score
            // from a reachable previous index (which is at the top of the PQ).
            dp[i] = nums[i] + pq.peek()[0];

            // Add the current index's score to the priority queue.
            pq.add(new int[]{dp[i], i});
        }

        // The result is the maximum score to reach the last index.
        return dp[n - 1];
    }
}