public class Solution {

import java.util.*;

public class Solution {
    public long maxScore(int[] nums, int[][] ranges) {
        Arrays.sort(ranges, (a, b) -> b[1] - a[1]);
        List<int[]> sorted = new ArrayList<>();
        for (int[] range : ranges) {
            sorted.add(range);
        }
        Collections.sort(sorted, (a, b) -> b[1] - a[1]);
        int n = nums.length;
        long[] score = new long[n];
        Arrays.fill(score, 0);
        for (int[] range : sorted) {
            int start = range[0];
            int end = range[1];
            int val = range[2];
            for (int i = start; i <= end; i++) {
                score[i] += val;
            }
        }
        long max = 0;
        for (long s : score) {
            if (s > max) {
                max = s;
            }
        }
        return max;
    }
}
}