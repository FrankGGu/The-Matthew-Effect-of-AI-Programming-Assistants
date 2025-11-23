import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] getSubarrayBeauty(int[] nums, int k, int x) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int i = 0; i < n; i++) {
            minHeap.offer(nums[i]);
            if (minHeap.size() > k) {
                minHeap.poll();
            }
            if (i >= k - 1) {
                int[] window = new int[k];
                for (int j = 0; j < k; j++) {
                    window[j] = nums[i - j];
                }
                Arrays.sort(window);
                if (x <= window.length) {
                    result[i - k + 1] = window[x - 1] < 0 ? window[x - 1] : 0;
                } else {
                    result[i - k + 1] = 0;
                }
            }
        }
        return result;
    }
}