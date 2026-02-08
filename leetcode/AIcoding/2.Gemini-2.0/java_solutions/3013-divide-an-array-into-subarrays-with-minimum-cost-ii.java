import java.util.PriorityQueue;

class Solution {
    public long minimumCost(int[] nums, int k, int dist) {
        int n = nums.length;
        long ans = Long.MAX_VALUE;

        for (int i = 1; i <= dist + 1; i++) {
            PriorityQueue<Integer> minHeap = new PriorityQueue<>();
            PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
            long sum = 0;

            for (int j = 1; j < i; j++) {
                maxHeap.offer(nums[j]);
                sum += nums[j];
            }

            while (maxHeap.size() > k - 1) {
                sum -= maxHeap.poll();
            }

            for (int j = i; j <= dist + 1; j++) {
                minHeap.offer(nums[j]);
                if (minHeap.size() > (dist + 1 - i + 1) - (k - 1)) {
                    maxHeap.offer(minHeap.poll());
                    sum += nums[j];

                    while (maxHeap.size() > k - 1) {
                        sum -= maxHeap.poll();
                    }
                }
            }

            ans = Math.min(ans, (long) nums[0] + sum);
        }

        return ans;
    }
}