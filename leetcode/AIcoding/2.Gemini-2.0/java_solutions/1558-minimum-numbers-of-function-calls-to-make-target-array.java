class Solution {
    public int minOperations(int[] nums) {
        int ans = 0;
        int maxBit = 0;
        for (int num : nums) {
            int bit = 0;
            int temp = num;
            while (temp > 0) {
                bit++;
                temp >>= 1;
            }
            maxBit = Math.max(maxBit, bit);
        }

        for (int i = 0; i < maxBit; i++) {
            boolean hasOdd = false;
            for (int j = 0; j < nums.length; j++) {
                if ((nums[j] & 1) == 1) {
                    hasOdd = true;
                    nums[j]--;
                    ans++;
                }
            }
            if (hasOdd) continue;
            boolean allZero = true;
            for (int j = 0; j < nums.length; j++) {
                if (nums[j] != 0) {
                    allZero = false;
                    break;
                }
            }
            if (!allZero) {
                for (int j = 0; j < nums.length; j++) {
                    nums[j] >>= 1;
                }
                ans++;
            }

        }

        return ans;
    }
}