class Solution {
    public boolean sumOfNumberAndReverse(int num) {
        for (int i = 0; i <= num; i++) {
            int reversed = reverse(i);
            if (i + reversed == num) {
                return true;
            }
        }
        return false;
    }

    private int reverse(int n) {
        int reversed = 0;
        while (n > 0) {
            int digit = n % 10;
            reversed = reversed * 10 + digit;
            n /= 10;
        }
        return reversed;
    }
}