import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctAverages(int[] nums) {
        Set<Double> averages = new HashSet<>();
        int n = nums.length;
        boolean[] visited = new boolean[n];
        Arrays.sort(nums);

        for (int i = 0; i < n / 2; i++) {
            double average = (nums[i] + nums[n - 1 - i]) / 2.0;
            averages.add(average);
        }

        return averages.size();
    }
}