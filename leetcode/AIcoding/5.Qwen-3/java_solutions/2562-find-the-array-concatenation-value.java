public class Solution {

import java.util.List;

public class Solution {
    public int findTheArrayConcatenationValue(List<Integer> nums) {
        int value = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left <= right) {
            if (left == right) {
                value += nums.get(left);
            } else {
                value += Integer.parseInt(nums.get(left).toString() + nums.get(right).toString());
            }
            left++;
            right--;
        }

        return value;
    }
}
}