class Solution {
    public int subarrayLCM(int[] nums, int k) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int currentLCM = nums[i];
            if (currentLCM == k) {
                count++;
            }
            for (int j = i + 1; j < n; j++) {
                currentLCM = lcm(currentLCM, nums[j]);
                if (currentLCM > k) {
                    break;
                }
                if (currentLCM == k) {
                    count++;
                }
            }
        }
        return count;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    private int lcm(int a, int b) {
        return a * b / gcd(a, b);
    }
}