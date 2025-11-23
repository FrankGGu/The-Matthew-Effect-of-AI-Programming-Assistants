class Solution {
    private int reverse(int n) {
        int reversedNum = 0;
        while (n > 0) {
            int digit = n % 10;
            reversedNum = reversedNum * 10 + digit;
            n /= 10;
        }
        return reversedNum;
    }

    public boolean sumOfNumberAndReverse(int num) {
        for (int x = 0; x <= num; x++) {
            if (x + reverse(x) == num) {
                return true;
            }
        }
        return false;
    }
}