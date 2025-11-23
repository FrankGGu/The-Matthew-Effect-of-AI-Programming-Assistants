public class Solution {

import java.util.*;

public class Solution {
    public long[] kSum(int[] nums, int k) {
        int n = nums.length;
        long[] result = new long[k];
        List<int[]> subarrays = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                subarrays.add(Arrays.copyOfRange(nums, i, j));
            }
        }

        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(b[0], a[0]));

        for (int[] sub : subarrays) {
            long sum = 0;
            for (int num : sub) {
                sum += num;
            }
            pq.offer(new long[]{sum, 0});
        }

        for (int i = 0; i < k; i++) {
            if (pq.isEmpty()) break;
            result[i] = pq.poll()[0];
        }

        return result;
    }
}
}