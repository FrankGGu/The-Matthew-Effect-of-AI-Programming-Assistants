class Solution {
    public int minOperations(int[] nums, int target) {
        int operations = 0;
        for (int i = 30; i >= 0; i--) {
            int mask = 1 << i;
            int sum = 0;
            for (int num : nums) {
                if ((num & mask) != 0) {
                    sum++;
                }
            }
            if ((target & mask) != 0) {
                if (sum == 0) {
                    boolean found = false;
                    for (int j = i + 1; j <= 30; j++) {
                        int higherMask = 1 << j;
                        if ((target & higherMask) != 0) {
                            continue;
                        }
                        for (int k = 0; k < nums.length; k++) {
                            if ((nums[k] & higherMask) != 0) {
                                operations += j - i;
                                nums[k] ^= higherMask;
                                for (int l = i; l < j; l++) {
                                    nums[k] |= (1 << l);
                                }
                                found = true;
                                break;
                            }
                        }
                        if (found) {
                            break;
                        }
                    }
                    if (!found) {
                        return -1;
                    }
                }
            }
            if (sum > 0) {
                for (int j = 0; j < nums.length; j++) {
                    if ((nums[j] & mask) != 0) {
                        if (sum > 1) {
                            nums[j] ^= mask;
                            operations++;
                            sum--;
                        }
                    }
                }
            }
        }
        return operations;
    }
}