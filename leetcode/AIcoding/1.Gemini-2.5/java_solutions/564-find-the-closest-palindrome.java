import java.util.TreeSet;
import java.lang.StringBuilder;
import java.lang.Math;

class Solution {
    public String nearestPalindromic(String n) {
        long num = Long.parseLong(n);
        int len = n.length();

        TreeSet<Long> candidates = new TreeSet<>();

        // Candidate 1: Palindrome with length (len - 1), e.g., 9, 99, 999
        // This covers cases like n = "100", closest is "99"
        candidates.add((long) Math.pow(10, len - 1) - 1);

        // Candidate 2: Palindrome with length (len + 1), e.g., 11, 101, 1001
        // This covers cases like n = "99", closest is "101"
        candidates.add((long) Math.pow(10, len) + 1);

        // Candidates based on the prefix of n (same length as n)
        // Get the first half of the number string
        String prefixStr = n.substring(0, (len + 1) / 2);
        long prefix = Long.parseLong(prefixStr);

        // Generate palindromes using prefix-1, prefix, and prefix+1
        // These cover cases where the palindrome has the same number of digits as n
        for (long i = prefix - 1; i <= prefix + 1; i++) {
            candidates.add(buildPalindrome(String.valueOf(i), len));
        }

        // Remove the original number itself from candidates, as we need the *closest* excluding itself.
        candidates.remove(num);

        long minDiff = Long.MAX_VALUE;
        long result = -1;

        // Iterate through candidates to find the closest one
        for (long candidatePali : candidates) {
            long diff = Math.abs(candidatePali - num);
            if (diff < minDiff) {
                minDiff = diff;
                result = candidatePali;
            } else if (diff == minDiff) {
                // If there's a tie in difference, return the smaller palindrome
                result = Math.min(result, candidatePali);
            }
        }

        return String.valueOf(result);
    }

    // Helper function to build a palindrome from a prefix string and a target length
    private long buildPalindrome(String prefix, int targetLen) {
        StringBuilder sb = new StringBuilder(prefix);
        String suffix = sb.reverse().toString();

        // If target length is odd, the middle digit is already in the prefix
        // so we remove the first character of the reversed prefix (which is the middle digit)
        if (targetLen % 2 == 1) {
            suffix = suffix.substring(1);
        }

        return Long.parseLong(prefix + suffix);
    }
}