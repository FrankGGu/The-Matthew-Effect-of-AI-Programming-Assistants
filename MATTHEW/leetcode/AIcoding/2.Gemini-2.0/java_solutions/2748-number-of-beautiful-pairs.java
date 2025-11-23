class Solution {
    public int countBeautifulPairs(int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                int firstDigit = String.valueOf(nums[i]).charAt(0) - '0';
                int lastDigit = nums[j] % 10;
                if (gcd(firstDigit, lastDigit) == 1) {
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
}