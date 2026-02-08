class Solution {
    public int findKOr(int[] nums, int k) {
        int ans = 0;
        for (int i = 0; i < 31; i++) {
            int count = 0;
            for (int num : nums) {
                if ((num & (1 << i)) != 0) {
                    count++;
                }
            }
            if (count >= k) {
                ans |= (1 << i);
            }
        }
        return ans;
    }
}