import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctAverages(int[] nums) {
        Arrays.sort(nums);
        Set<Double> distinctAverages = new HashSet<>();
        int left = 0;
        int right = nums.length - 1;

        while (left < right) {
            double average = (double) (nums[left] + nums[right]) / 2.0;
            distinctAverages.add(average);
            left++;
            right--;
        }

        return distinctAverages.size();
    }
}