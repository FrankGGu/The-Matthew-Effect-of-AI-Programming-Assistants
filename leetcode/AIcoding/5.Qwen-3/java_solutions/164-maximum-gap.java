public class Solution {

import java.util.*;

public class Solution {
    public int maximumGap(int[] nums) {
        if (nums.length < 2) return 0;

        int n = nums.length;
        int minVal = Arrays.stream(nums).min().getAsInt();
        int maxVal = Arrays.stream(nums).max().getAsInt();

        double gap = (double) (maxVal - minVal) / (n - 1);
        if (gap == 0) return 0;

        List<List<Integer>> buckets = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            buckets.add(new ArrayList<>());
        }

        for (int num : nums) {
            if (num == minVal) continue;
            int index = (int) ((num - minVal) / gap);
            buckets.get(index).add(num);
        }

        int maxGap = 0;
        int prev = minVal;

        for (List<Integer> bucket : buckets) {
            if (bucket.isEmpty()) continue;
            int currentMin = Collections.min(bucket);
            maxGap = Math.max(maxGap, currentMin - prev);
            prev = Collections.max(bucket);
        }

        return maxGap;
    }
}
}