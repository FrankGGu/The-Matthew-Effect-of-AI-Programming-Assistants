class Solution {
    public int[] distinctDifferenceArray(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Set<Integer> prefix = new HashSet<>();
        Set<Integer> suffix = new HashSet<>();

        for (int i = 0; i < n; i++) {
            prefix.add(nums[i]);
            suffix.clear();
            for (int j = i + 1; j < n; j++) {
                suffix.add(nums[j]);
            }
            result[i] = prefix.size() - suffix.size();
        }

        return result;
    }
}