class Solution {
    public int countCompleteSubarrays(int[] nums) {
        Set<Integer> distinct = new HashSet<>();
        for (int num : nums) {
            distinct.add(num);
        }
        int k = distinct.size();
        int n = nums.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            Set<Integer> current = new HashSet<>();
            for (int j = i; j < n; j++) {
                current.add(nums[j]);
                if (current.size() == k) {
                    count += (n - j);
                    break;
                }
            }
        }

        return count;
    }
}