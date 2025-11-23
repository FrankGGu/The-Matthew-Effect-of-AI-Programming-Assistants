public class Solution {

import java.util.*;

public class Solution {
    public int kthSmallestSum(int[] nums1, int[] nums2, int k) {
        int m = nums1.length, n = nums2.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (nums1[a[0]] + nums2[a[1]] - nums1[b[0]] - nums2[b[1]]));
        Set<String> visited = new HashSet<>();
        pq.offer(new int[]{0, 0});
        visited.add("0,0");

        while (!pq.isEmpty() && k > 0) {
            int[] curr = pq.poll();
            int i = curr[0], j = curr[1];
            if (k == 1) return nums1[i] + nums2[j];
            k--;
            if (i + 1 < m && !visited.contains((i + 1) + "," + j)) {
                pq.offer(new int[]{i + 1, j});
                visited.add((i + 1) + "," + j);
            }
            if (j + 1 < n && !visited.contains(i + "," + (j + 1))) {
                pq.offer(new int[]{i, j + 1});
                visited.add(i + "," + (j + 1));
            }
        }
        return -1;
    }
}
}