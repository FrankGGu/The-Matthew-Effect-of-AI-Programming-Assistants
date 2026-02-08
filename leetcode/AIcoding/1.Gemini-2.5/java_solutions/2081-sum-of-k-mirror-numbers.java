import java.util.ArrayList;
import java.util.List;

class Solution {
    public long sumKMirror(int n, int k) {
        long totalSum = 0;
        int count = 0;

        // Iterate through potential "first halves" of base-10 palindromes.
        // This systematically generates base-10 palindromes in increasing order.
        // For example:
        // i=1 -> 1 (odd), 11 (even)
        // i=2 -> 2 (odd), 22 (even)
        // ...
        // i=9 -> 9 (odd), 99 (even)
        // i=10 -> 101 (odd), 1001 (even)
        // i=11 -> 111 (odd), 1111 (even)
        for (long i = 1; ; i++) {
            // Generate odd-length base-10 palindrome
            long oddPalindrome = buildPalindrome(i, true);
            if (isKPalindrome(oddPalindrome, k)) {
                totalSum += oddPalindrome;
                count++;
                if (count == n) {
                    return totalSum;
                }
            }

            // Generate even-length base-10 palindrome
            long evenPalindrome = buildPalindrome(i, false);
            if (isKPalindrome(evenPalindrome, k)) {
                totalSum += evenPalindrome;
                count++;
                if (count == n) {
                    return totalSum;
                }
            }
        }
    }

    // Helper function to build a base-10 palindrome from its first half.
    // firstHalf: The left part of the palindrome (e.g., 12 for 121 or 1221).
    // isOddLength: True if the palindrome should have an odd number of digits (e.g., 121),
    //              False if it should have an even number of digits (e.g., 1221).
    private long buildPalindrome(long firstHalf, boolean isOddLength) {
        long palindrome = firstHalf;
        // If odd length, the middle digit is the last digit of firstHalf, so exclude it from reversal.
        long temp = isOddLength ? firstHalf / 10 : firstHalf;

        while (temp > 0) {
            palindrome = palindrome * 10 + (temp % 10);
            temp /= 10;
        }
        return palindrome;
    }

    // Helper function to check if a number is a palindrome in base k.
    private boolean isKPalindrome(long num, int k) {
        // Convert num to its base k digits.
        // Digits are stored in reverse order of significance (least significant first).
        List<Integer> digits = new ArrayList<>();
        long temp = num;
        while (temp > 0) {
            digits.add((int) (temp % k));
            temp /= k;
        }

        // Check if the list of base k digits forms a palindrome.
        int left = 0;
        int right = digits.size() - 1;
        while (left < right) {
            if (!digits.get(left).equals(digits.get(right))) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}