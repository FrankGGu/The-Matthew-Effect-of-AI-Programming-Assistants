class Solution {
    public int subarrayLCM(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int currentLCM = 1;
            for (int j = i; j < nums.length; j++) {
                currentLCM = lcm(currentLCM, nums[j]);
                if (currentLCM == k) {
                    count++;
                } else if (currentLCM > k) {
                    break;
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
        return (a * b) / gcd(a, b);
    }
}