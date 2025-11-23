class Solution {
    public int alternateDigitSum(int n) {
        int sum = 0;
        boolean add = true;
        while (n > 0) {
            int digit = n % 10;
            sum += add ? digit : -digit;
            add = !add;
            n /= 10;
        }
        return sum;
    }
}