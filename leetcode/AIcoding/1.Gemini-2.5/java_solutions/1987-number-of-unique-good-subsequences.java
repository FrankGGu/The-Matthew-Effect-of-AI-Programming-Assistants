import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int countUniqueGoodSubsequences(String s) {
        int n = s.length();

        int[] firstOccurrence = new int[10];
        Arrays.fill(firstOccurrence, -1);
        int[] lastOccurrence = new int[10];
        Arrays.fill(lastOccurrence, -1);

        for (int i = 0; i < n; i++) {
            int digit = s.charAt(i) - '0';
            if (firstOccurrence[digit] == -1) {
                firstOccurrence[digit] = i;
            }
            lastOccurrence[digit] = i;
        }

        long totalGoodSubsequences = 0;

        for (int digit = 0; digit <= 9; digit++) {
            if (firstOccurrence[digit] != -1 && firstOccurrence[digit] != lastOccurrence[digit]) {
                int startIdx = firstOccurrence[digit] + 1;
                int endIdx = lastOccurrence[digit];

                long innerUniqueSubsequences = 0;
                if (startIdx <= endIdx) {
                    innerUniqueSubsequences = countUniqueSubsequencesForRange(s, startIdx, endIdx);
                }

                totalGoodSubsequences = (totalGoodSubsequences + innerUniqueSubsequences + 1) % MOD;
            }
        }

        return (int) totalGoodSubsequences;
    }

    private long countUniqueSubsequencesForRange(String s, int start, int end) {
        long total_unique_subsequences = 0;
        long[] ends_with = new long[10];

        for (int i = start; i < end; i++) {
            int digit = s.charAt(i) - '0';

            long num_new_subsequences_ending_with_digit = (total_unique_subsequences + 1) % MOD;

            long current_ends_with_digit = ends_with[digit];

            ends_with[digit] = num_new_subsequences_ending_with_digit;

            total_unique_subsequences = (total_unique_subsequences + num_new_subsequences_ending_with_digit - current_ends_with_digit + MOD) % MOD;
        }
        return total_unique_subsequences;
    }
}