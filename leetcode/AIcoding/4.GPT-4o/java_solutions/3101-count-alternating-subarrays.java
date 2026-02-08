class Solution {
    public int countAlternatingSubarrays(int[] nums) {
        int count = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            if (nums[i] % 2 == 0) {
                int length = 1;
                for (int j = i + 1; j < n && nums[j] != nums[j - 1]; j++) {
                    length++;
                    count++;
                }
                count += length - 1;
            }
        }
        return count;
    }
}