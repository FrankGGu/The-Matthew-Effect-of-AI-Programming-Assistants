class Solution {
    public int findSubarrayWithOR(int[] nums, int k) {
        int n = nums.length;
        int ans = n;
        for (int i = 0; i < n; i++) {
            int or = 0;
            for (int j = i; j < n; j++) {
                or |= nums[j];
                if (or == k) {
                    ans = Math.min(ans, j - i + 1);
                } else if (or > k) {
                    if (or - k < k - (or ^ nums[j])) {
                        ans = Math.min(ans, j - i + 1);
                    } else if (or - k == k - (or ^ nums[j])){
                        ans = Math.min(ans, j - i + 1);
                    }
                } else {
                    if (k - or < or - (or ^ nums[j])) {
                        ans = Math.min(ans, j - i + 1);
                    } else if (k - or == or - (or ^ nums[j])) {
                        ans = Math.min(ans, j - i + 1);
                    }
                }
            }
        }
        return ans;
    }
}