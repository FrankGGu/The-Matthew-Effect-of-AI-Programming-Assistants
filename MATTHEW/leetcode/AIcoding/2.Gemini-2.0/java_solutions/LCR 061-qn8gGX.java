import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public List<List<Integer>> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums1 == null || nums2 == null || nums1.length == 0 || nums2.length == 0 || k <= 0) {
            return result;
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (a[0] + a[1]) - (b[0] + b[1]));

        for (int i = 0; i < Math.min(nums1.length, k); i++) {
            pq.offer(new int[]{nums1[i], nums2[0], 0});
        }

        while (k > 0 && !pq.isEmpty()) {
            int[] curr = pq.poll();
            List<Integer> pair = new ArrayList<>();
            pair.add(curr[0]);
            pair.add(curr[1]);
            result.add(pair);

            int index2 = curr[2];
            if (index2 < nums2.length - 1) {
                pq.offer(new int[]{curr[0], nums2[index2 + 1], index2 + 1});
            }
            k--;
        }

        return result;
    }
}