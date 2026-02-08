var countPalindromicSubsequences = function(s) {
    const n = s.length;
    let totalPalindromes = 0;

    // left_digit_seen[i][d] is true if digit d appears in s[0...i-1]
    const left_digit_seen = Array(n + 1).fill(0).map(() => Array(10).fill(false));
    // left_pairs[i][d1][d2] is true if d1 d2 is a subsequence in s[0...i-1]
    const left_pairs = Array(n + 1).fill(0).map(() => Array(10).fill(0).map(() => Array(10).fill(false)));

    for (let i = 0; i < n; i++) {
        const current_char_val = parseInt(s[i]);
        // Copy previous state
        for (let d = 0; d < 10; d++) {
            left_digit_seen[i + 1][d] = left_digit_seen[i][d];
        }
        for (let d1 = 0; d1 < 10; d1++) {
            for (let d2 = 0; d2 < 10; d2++) {
                left_pairs[i + 1][d1][d2] = left_pairs[i][d1][d2];
            }
        }

        // Update for current character s[i]
        // For every digit d1 seen before index i, (d1, current_char_val) forms a new pair
        for (let d1 = 0; d1 < 10; d1++) {
            if (left_digit_seen[i][d1]) {
                left_pairs[i + 1][d1][current_char_val] = true;
            }
        }
        // Mark current_char_val as seen up to index i
        left_digit_seen[i + 1][current_char_val] = true;
    }

    // right_digit_seen[i][d] is true if digit d appears in s[i...n-1]
    const right_digit_seen = Array(n + 1).fill(0).map(() => Array(10).fill(false));
    // right_pairs[i][d1][d2] is true if d1 d2 is a subsequence in s[i...n-1]
    const right_pairs = Array(n + 1).fill(0).map(() => Array(10).fill(0).map(() => Array(10).fill(false)));

    for (let i = n - 1; i >= 0; i--) {
        const current_char_val = parseInt(s[i]);
        // Copy previous state
        for (let d = 0; d < 10; d++) {
            right_digit_seen[i][d] = right_digit_seen[i + 1][d];
        }
        for (let d1 = 0; d1 < 10; d1++) {
            for (let d2 = 0; d2 < 10; d2++) {
                right_pairs[i][d1][d2] = right_pairs[i + 1][d1][d2];
            }
        }

        // Update for current character s[i]
        // For every digit d2 seen after index i, (current_char_val, d2) forms a new pair
        for (let d2 = 0; d2 < 10; d2++) {
            if (right_digit_seen[i + 1][d2]) {
                right_pairs[i][current_char_val][d2] = true;
            }
        }
        // Mark current_char_val as seen from index i onwards
        right_digit_seen[i][current_char_val] = true;
    }

    // Iterate through all possible middle characters (s[k_mid])
    // A palindrome of length 5 is of the form x y z y x.
    // k_mid is the index of 'z'.
    // We need at least 2 characters to its left (for x y) and 2 to its right (for y x).
    // So k_mid must be at least 2, and at most n-3.
    for (let k_mid = 2; k_mid <= n - 3; k_mid++) {
        for (let x = 0; x < 10; x++) {
            for (let y = 0; y < 10; y++) {
                // Check if 'x y' is a subsequence in s[0...k_mid-1] (left part)
                // Check if 'y x' is a subsequence in s[k_mid+1...n-1] (right part)
                if (left_pairs[k_mid][x][y] && right_pairs[k_mid + 1][y][x]) {
                    totalPalindromes++;
                }
            }
        }
    }

    return totalPalindromes;
};