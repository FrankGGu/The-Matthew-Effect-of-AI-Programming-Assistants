class Solution {
    public int primePalindrome(int N) {
        if (N <= 2) return 2;
        if (8 <= N && N <= 11) return 11;
        for (int x = 1; x < 100000; x++) {
            String s = Integer.toString(x);
            String r = new StringBuilder(s).reverse().toString();
            int y = Integer.parseInt(s + r.substring(1));
            if (y >= N && isPrime(y)) return y;
        }
        return -1;
    }

    private boolean isPrime(int num) {
        if (num < 2 || num % 2 == 0) return num == 2;
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) return false;
        }
        return true;
    }
}