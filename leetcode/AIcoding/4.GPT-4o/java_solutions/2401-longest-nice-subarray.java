import java.util.HashSet;

class Solution {
    public int longestNiceSubarray(int[] nums) {
        HashSet<Integer> set = new HashSet<>();
        int left = 0, maxLength = 0;

        for (int right = 0; right < nums.length; right++) {
            while (set.contains(nums[right])) {
                set.remove(nums[left]);
                left++;
            }
            set.add(nums[right]);
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}