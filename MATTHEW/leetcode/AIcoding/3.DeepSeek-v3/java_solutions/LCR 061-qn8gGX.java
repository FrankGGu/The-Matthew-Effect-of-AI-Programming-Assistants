class Solution {
    public List<List<Integer>> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums1.length == 0 || nums2.length == 0 || k == 0) {
            return result;
        }

        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) -> (nums1[a[0]] + nums2[a[1]]) - (nums1[b[0]] + nums2[b[1]]));

        for (int i = 0; i < nums1.length && i < k; i++) {
            heap.offer(new int[]{i, 0});
        }

        while (k-- > 0 && !heap.isEmpty()) {
            int[] current = heap.poll();
            List<Integer> pair = new ArrayList<>();
            pair.add(nums1[current[0]]);
            pair.add(nums2[current[1]]);
            result.add(pair);

            if (current[1] + 1 < nums2.length) {
                heap.offer(new int[]{current[0], current[1] + 1});
            }
        }

        return result;
    }
}