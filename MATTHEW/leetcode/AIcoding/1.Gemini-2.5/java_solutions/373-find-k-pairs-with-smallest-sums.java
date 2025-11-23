import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public List<List<Integer>> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums1 == null || nums1.length == 0 || nums2 == null || nums2.length == 0 || k == 0) {
            return result;
        }

        // The priority queue stores int arrays: [sum, index_in_nums1, index_in_nums2]
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        // Initialize the priority queue with pairs (nums1[i], nums2[0]) for all i.
        // We only need to add up to k such initial pairs, as we only need k total pairs.
        // However, adding all nums1.length pairs ensures we cover all starting points.
        // The size of the PQ will be at most nums1.length.
        for (int i = 0; i < nums1.length && i < k; i++) {
            pq.offer(new int[]{nums1[i] + nums2[0], i, 0});
        }

        while (k > 0 && !pq.isEmpty()) {
            int[] current = pq.poll();
            int i = current[1]; // index in nums1
            int j = current[2]; // index in nums2

            List<Integer> pair = new ArrayList<>();
            pair.add(nums1[i]);
            pair.add(nums2[j]);
            result.add(pair);
            k--;

            // If there's a next element in nums2, add the pair (nums1[i], nums2[j+1]) to the PQ
            if (j + 1 < nums2.length) {
                pq.offer(new int[]{nums1[i] + nums2[j + 1], i, j + 1});
            }
        }

        return result;
    }
}