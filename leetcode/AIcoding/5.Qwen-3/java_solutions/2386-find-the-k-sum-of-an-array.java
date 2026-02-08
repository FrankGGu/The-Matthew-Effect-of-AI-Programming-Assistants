public class Solution {

import java.util.*;

public class Solution {
    public double kSum(List<Integer> nums, int k) {
        int n = nums.size();
        Arrays.sort(nums);
        List<Double> sums = new ArrayList<>();
        sums.add(0.0);
        for (int i = 0; i < n; i++) {
            int num = nums.get(i);
            List<Double> newSums = new ArrayList<>();
            for (double sum : sums) {
                newSums.add(sum + num);
            }
            sums.addAll(newSums);
        }
        Collections.sort(sums);
        return sums.get(k - 1);
    }
}
}