import java.util.List;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxPalindromesAfterOperations(String[] words, int k) {
        int[] counts = new int[26];
        for (String word : words) {
            for (char c : word.toCharArray()) {
                counts[c - 'a']++;
            }
        }

        int totalPairs = 0;
        int totalSingles = 0;
        for (int count : counts) {
            totalPairs += count / 2;
            totalSingles += count % 2;
        }

        int numPalindromes = 0;

        // Step 1: Form as many length-2 palindromes as possible using character pairs.
        // Each length-2 palindrome consumes 1 pair and 2 units of length.
        // We are limited by the total number of pairs and the remaining length budget 'k'.
        int canFormFromPairs = Math.min(totalPairs, k / 2);
        numPalindromes += canFormFromPairs;
        k -= (canFormFromPairs * 2);

        // Step 2: Use remaining single characters to form length-1 palindromes.
        // Each length-1 palindrome consumes 1 single character and 1 unit of length.
        // We are limited by the total number of single characters and the remaining length budget 'k'.
        // These single characters can either form new length-1 palindromes or extend existing ones to odd lengths.
        // To maximize the count, we prefer forming new length-1 palindromes.
        int canFormFromSingles = Math.min(totalSingles, k);
        numPalindromes += canFormFromSingles;
        // No need to update k further as we've exhausted all options to increase palindrome count.

        return numPalindromes;
    }
}