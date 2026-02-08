class Solution {
    public int primePalindrome(int n) {
        if (n >= 8 && n <= 11) return 11;
        for (int i = 1; i <= 100000; i++) {
            String s = String.valueOf(i);
            String r = new StringBuilder(s).reverse().toString();
            long num = Long.parseLong(s + r.substring(1));
            if (num >= n && isPrime((int) num)) {
                return (int) num;
            }
        }
        return -1;
    }

    private boolean isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}