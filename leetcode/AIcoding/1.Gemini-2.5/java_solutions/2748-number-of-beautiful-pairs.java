class Solution {
    public int countBeautifulPairs(int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int firstDigitI = getFirstDigit(nums[i]);
            for (int j = i + 1; j < nums.length; j++) {
                int lastDigitJ = getLastDigit(nums[j]);
                if (gcd(firstDigitI, lastDigitJ) == 1) {
                    count++;
                }
            }
        }
        return count;
    }

    private int getFirstDigit(int n) {
        while (n >= 10) {
            n /= 10;
        }
        return n;
    }

    private int getLastDigit(int n) {
        return n % 10;
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