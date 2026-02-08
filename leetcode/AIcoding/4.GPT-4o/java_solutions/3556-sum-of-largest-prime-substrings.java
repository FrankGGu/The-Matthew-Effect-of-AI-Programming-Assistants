class Solution {
    public int largestPrimeSubstring(String s) {
        int maxPrime = -1;
        for (int len = 1; len <= s.length(); len++) {
            for (int start = 0; start <= s.length() - len; start++) {
                String substring = s.substring(start, start + len);
                if (isPrime(Integer.parseInt(substring))) {
                    maxPrime = Math.max(maxPrime, Integer.parseInt(substring));
                }
            }
        }
        return maxPrime;
    }

    private boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i <= Math.sqrt(num); i++) {
            if (num % i == 0) return false;
        }
        return true;
    }
}