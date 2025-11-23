class Solution {
    public int findKOr(int[] nums, int k) {
        int kOrResult = 0;
        for (int i = 0; i < 31; i++) {
            int countSetBits = 0;
            for (int num : nums) {
                if (((num >> i) & 1) == 1) {
                    countSetBits++;
                }
            }
            if (countSetBits >= k) {
                kOrResult |= (1 << i);
            }
        }
        return kOrResult;
    }
}