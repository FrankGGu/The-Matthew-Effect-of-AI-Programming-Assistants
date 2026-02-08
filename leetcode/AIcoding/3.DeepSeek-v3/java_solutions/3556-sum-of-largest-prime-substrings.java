import java.util.*;

class Solution {
    public int sumLargestPrimeSubstrings(String s) {
        int maxSum = 0;
        int currentNum = 0;
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                currentNum = currentNum * 10 + (s.charAt(i) - '0');
                if (isPrime(currentNum)) {
                    if (currentNum > maxSum) {
                        maxSum = currentNum;
                    }
                }
            } else {
                currentNum = 0;
            }
        }
        return maxSum;
    }

    private boolean isPrime(int num) {
        if (num <= 1) {
            return false;
        }
        if (num == 2) {
            return true;
        }
        if (num % 2 == 0) {
            return false;
        }
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}