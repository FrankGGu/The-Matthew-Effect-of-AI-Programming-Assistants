import java.util.PriorityQueue;

class Solution {
    public long[] unmarkedSumArray(int[] nums, int[][] queries) {
        int n = nums.length;
        long currentSum = 0;
        boolean[] visited = new boolean[n];
        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        for (int i = 0; i < n; i++) {
            currentSum += nums[i];
            minHeap.offer(new int[]{nums[i], i});
        }

        long[] ans = new long[queries.length];

        for (int qIdx = 0; qIdx < queries.length; qIdx++) {
            ans[qIdx] = currentSum;

            int indexToMark = queries[qIdx][0];
            int kToMark = queries[qIdx][1];

            if (!visited[indexToMark]) {
                visited[indexToMark] = true;
                currentSum -= nums[indexToMark];
            }

            int markedCount = 0;
            while (markedCount < kToMark && !minHeap.isEmpty()) {
                int[] smallest = minHeap.poll();
                int val = smallest[0];
                int originalIdx = smallest[1];

                if (!visited[originalIdx]) {
                    visited[originalIdx] = true;
                    currentSum -= val;
                    markedCount++;
                }
            }
        }

        return ans;
    }
}