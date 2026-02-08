import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] advantageCount(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] result = new int[n];
        Arrays.sort(nums1);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        for (int i = 0; i < n; i++) {
            pq.offer(new int[]{nums2[i], i});
        }

        int left = 0, right = n - 1;
        while (!pq.isEmpty()) {
            int[] top = pq.poll();
            int index = top[1];
            int val = top[0];

            if (nums1[right] > val) {
                result[index] = nums1[right];
                right--;
            } else {
                result[index] = nums1[left];
                left++;
            }
        }

        return result;
    }
}