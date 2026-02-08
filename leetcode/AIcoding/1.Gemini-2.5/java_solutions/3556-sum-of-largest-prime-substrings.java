class Solution {
    private boolean isPrime(long num) {
        if (num <= 1) {
            return false;
        }
        if (num == 2 || num == 3) {
            return true;
        }
        if (num % 2 == 0 || num % 3 == 0) {
            return false;
        }
        for (long i = 5; i * i <= num; i = i + 6) {
            if (num % i == 0 || num % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }

    public long sumOfLargestPrimeSubstrings(String s) {
        int n = s.length();
        long totalSum = 0;

        for (int i = 0; i < n; i++) {
            long longestPrimeValueForCurrentI = 0;
            for (int j = i; j < n; j++) {
                String subStr = s.substring(i, j + 1);

                // If the substring represents a number with leading zeros (e.g., "01", "007")
                // and its length is greater than 1, it's usually considered invalid or just its value.
                // Long.parseLong("01") correctly yields 1. Long.parseLong("0") yields 0.
                // We rely on isPrime(0) being false and isPrime(1) being false.
                // If the problem implies that "01" is an invalid number string,
                // this check would be needed:
                // if (subStr.length() > 1 && subStr.charAt(0) == '0') {
                //     continue;
                // }
                // For typical LeetCode problems, Long.parseLong handles this gracefully.

                long currentNum = Long.parseLong(subStr);

                if (isPrime(currentNum)) {
                    // Since 'j' increases, the length of 'subStr' increases.
                    // The last prime number found for a given 'i' will correspond
                    // to the longest prime substring starting at 'i'.
                    longestPrimeValueForCurrentI = currentNum;
                }
            }
            totalSum += longestPrimeValueForCurrentI;
        }

        return totalSum;
    }
}