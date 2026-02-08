#include <string.h> // For strlen

#define MOD 1000000007

int countPalindromicSubsequences(char * s){
    int n = strlen(s);
    if (n < 5) {
        return 0;
    }

    // prefix_counts[i][d]: count of digit 'd' in s[0...i-1]
    long long prefix_counts[n + 1][10];
    // prefix_pairs[i][d1][d2]: count of subsequence "d1 d2" in s[0...i-1]
    long long prefix_pairs[n + 1][10][10];

    // suffix_counts[i][d]: count of digit 'd' in s[i...n-1]
    long long suffix_counts[n + 1][10];
    // suffix_pairs[i][d1][d2]: count of subsequence "d1 d2" in s[i...n-1]
    long long suffix_pairs[n + 1][10][10];

    // Initialize all to 0
    memset(prefix_counts, 0, sizeof(prefix_counts));
    memset(prefix_pairs, 0, sizeof(prefix_pairs));
    memset(suffix_counts, 0, sizeof(suffix_counts));
    memset(suffix_pairs, 0, sizeof(suffix_pairs));

    // Calculate prefix_counts and prefix_pairs
    // prefix_counts[i+1] and prefix_pairs[i+1] represent s[0...i]
    for (int i = 0; i < n; i++) {
        int curr_digit = s[i] - '0';
        for (int d = 0; d < 10; d++) {
            // Copy counts and pairs from previous step (s[0...i-1])
            prefix_counts[i + 1][d] = prefix_counts[i][d];
            for (int d1 = 0; d1 < 10; d1++) {
                prefix_pairs[i + 1][d1][d] = prefix_pairs[i][d1][d];
            }
        }

        // Update pairs where curr_digit is the second digit (d2)
        // The first digit d1 must come from s[0...i-1], whose counts are in prefix_counts[i]
        for (int d1 = 0; d1 < 10; d1++) {
            prefix_pairs[i + 1][d1][curr_digit] = (prefix_pairs[i + 1][d1][curr_digit] + prefix_counts[i][d1]) % MOD;
        }

        // Update count for curr_digit
        prefix_counts[i + 1][curr_digit]++;
    }

    // Calculate suffix_counts and suffix_pairs
    // suffix_counts[i] and suffix_pairs[i] represent s[i...n-1]
    for (int i = n - 1; i >= 0; i--) {
        int curr_digit = s[i] - '0';
        for (int d = 0; d < 10; d++) {
            // Copy counts and pairs from next step (s[i+1...n-1])
            suffix_counts[i][d] = suffix_counts[i + 1][d];
            for (int d2 = 0; d2 < 10; d2++) {
                suffix_pairs[i][d][d2] = suffix_pairs[i + 1][d][d2];
            }
        }

        // Update pairs where curr_digit is the first digit (d1)
        // The second digit d2 must come from s[i+1...n-1], whose counts are in suffix_counts[i+1]
        for (int d2 = 0; d2 < 10; d2++) {
            suffix_pairs[i][curr_digit][d2] = (suffix_pairs[i][curr_digit][d2] + suffix_counts[i + 1][d2]) % MOD;
        }

        // Update count for curr_digit
        suffix_counts[i][curr_digit]++;
    }

    long long total_palindromes = 0;

    // Iterate through all possible middle characters (X) at index k
    // A palindromic subsequence of length 5 is of the form c1 c2 X c2 c1
    // This implies there must be at least two characters before X and two characters after X.
    // So k must be at least 2 (for c1 c2) and at most n-3 (for c2 c1).
    for (int k = 2; k <= n - 3; k++) {
        // For each k, iterate through all possible pairs (c1, c2)
        for (int c1 = 0; c1 < 10; c1++) {
            for (int c2 = 0; c2 < 10; c2++) {
                // count_before: Number of "c1 c2" subsequences in s[0...k-1]
                // This is given by prefix_pairs[k][c1][c2]
                long long count_before = prefix_pairs[k][c1][c2];

                // count_after: Number of "c2 c1" subsequences in s[k+1...n-1]
                // This is given by suffix_pairs[k+1][c2][c1]
                long long count_after = suffix_pairs[k + 1][c2][c1];

                total_palindromes = (total_palindromes + (count_before * count_after) % MOD) % MOD;
            }
        }
    }

    return (int)total_palindromes;
}