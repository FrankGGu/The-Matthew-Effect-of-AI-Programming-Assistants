class Solution {
    public int findValidSplit(int[] nums) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        int[] last = new int[n + 1];
        for (int i = 0; i < n; i++) {
            last[i + 1] = gcd(last[i], nums[i]);
        }
        for (int i = 0; i < n; i++) {
            if (last[i + 1] == 1) {
                return i + 1;
            }
        }
        return -1;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}