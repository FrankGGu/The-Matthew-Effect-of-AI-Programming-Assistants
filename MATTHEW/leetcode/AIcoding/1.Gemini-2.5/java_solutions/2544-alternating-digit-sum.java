class Solution {
    public int alternatingDigitSum(int n) {
        String s = String.valueOf(n);
        int sum = 0;
        int sign = 1;

        for (int i = 0; i < s.length(); i++) {
            int digit = s.charAt(i) - '0';
            sum += digit * sign;
            sign *= -1;
        }

        return sum;
    }
}