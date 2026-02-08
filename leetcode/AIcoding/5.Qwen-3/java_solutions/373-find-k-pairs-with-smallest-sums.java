public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> nums1[a[0]] + nums2[a[1]] - nums1[b[0]] - nums2[b[1]]);
        Set<String> visited = new HashSet<>();
        List<List<Integer>> result = new ArrayList<>();

        if (nums1.length == 0 || nums2.length == 0 || k == 0) {
            return result;
        }

        minHeap.offer(new int[]{0, 0});
        visited.add("0,0");

        while (k-- > 0 && !minHeap.isEmpty()) {
            int[] curr = minHeap.poll();
            int i = curr[0], j = curr[1];
            List<Integer> pair = new ArrayList<>();
            pair.add(nums1[i]);
            pair.add(nums2[j]);
            result.add(pair);

            String next1 = (i + 1) + "," + j;
            if (!visited.contains(next1)) {
                minHeap.offer(new int[]{i + 1, j});
                visited.add(next1);
            }

            String next2 = i + "," + (j + 1);
            if (!visited.contains(next2)) {
                minHeap.offer(new int[]{i, j + 1});
                visited.add(next2);
            }
        }

        return result;
    }
}
}