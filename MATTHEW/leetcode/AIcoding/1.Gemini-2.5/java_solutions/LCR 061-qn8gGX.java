import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public List<List<Integer>> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums1.length == 0 || nums2.length == 0 || k == 0) {
            return result;
        }

        // The priority queue stores int arrays: [sum, index_in_nums1, index_in_nums2]
        // It is a min-heap based on the sum.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        // Initialize the priority queue with pairs (nums1[i], nums2[0]) for i from 0 to min(k-1, nums1.length-1)
        // We only need to consider up to k elements from nums1 as starting points
        // because we are looking for k smallest sums.
        for (int i = 0; i < Math.min(nums1.length, k); i++) {
            pq.offer(new int[]{nums1[i] + nums2[0], i, 0});
        }

        // Extract k smallest pairs
        while (k > 0 && !pq.isEmpty()) {
            int[] current = pq.poll();
            int sum = current[0];
            int idx1 = current[1];
            int idx2 = current[2];

            List<Integer> pair = new ArrayList<>();
            pair.add(nums1[idx1]);
            pair.add(nums2[idx2]);
            result.add(pair);
            k--;

            // If there's a next element in nums2 for the current nums1[idx1],
            // add the pair (nums1[idx1], nums2[idx2 + 1]) to the priority queue.
            // This ensures we explore sums in increasing order.
            if (idx2 + 1 < nums2.length) {
                pq.offer(new int[]{nums1[idx1] + nums2[idx2 + 1], idx1, idx2 + 1});
            }
        }

        return result;
    }
}