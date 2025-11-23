import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctAverages(int[] nums) {
        Arrays.sort(nums);
        int left = 0;
        int right = nums.length - 1;
        Set<Double> averages = new HashSet<>();
        while (left < right) {
            averages.add((double) (nums[left] + nums[right]) / 2);
            left++;
            right--;
        }
        return averages.size();
    }
}