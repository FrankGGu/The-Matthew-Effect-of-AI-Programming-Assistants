class Solution {
    public int primePalindrome(int n) {
        if (n <= 2) return 2;
        if (n % 2 == 0) n++;

        while (true) {
            if (isPalindrome(n) && isPrime(n)) {
                return n;
            }
            n += 2;
        }
    }

    private boolean isPalindrome(int x) {
        int rev = 0, original = x;
        while (x > 0) {
            rev = rev * 10 + x % 10;
            x /= 10;
        }
        return rev == original;
    }

    private boolean isPrime(int x) {
        if (x < 2) return false;
        for (int i = 2; i * i <= x; i++) {
            if (x % i == 0) return false;
        }
        return true;
    }
}