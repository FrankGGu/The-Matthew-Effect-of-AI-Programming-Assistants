import java.util.Arrays;

class Solution {
    public long minimalKSum(int[] nums, int k) {
        Arrays.sort(nums);
        long sum = 0;
        long current = 1;
        int index = 0;
        while (k > 0) {
            if (index < nums.length && nums[index] <= current) {
                current = nums[index] + 1;
                index++;
            } else {
                sum += current;
                current++;
                k--;
            }
        }
        return sum;
    }
}