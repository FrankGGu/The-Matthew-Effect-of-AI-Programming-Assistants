var countPalindromicSubsequences = function(s) {
    const n = s.length;
    const MOD = 10**9 + 7;

    // dp[i][j] stores the number of different palindromic subsequences in s[i...j]
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    // next_char[i][char_code] stores the index of the next occurrence of char_code at or after i
    const next_char = Array(n + 1).fill(0).map(() => Array(26).fill(0));
    // prev_char[i][char_code] stores the index of the previous occurrence of char_code at or before i
    const prev_char = Array(n).fill(0).map(() => Array(26).fill(0));

    // Precompute next_char
    for (let char_code = 0; char_code < 26; char_code++) {
        next_char[n][char_code] = n; // Sentinel value if not found
    }
    for (let i = n - 1; i >= 0; i--) {
        for (let char_code = 0; char_code < 26; char_code++) {
            next_char[i][char_code] = next_char[i + 1][char_code];
        }
        next_char[i][s.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    // Precompute prev_char
    for (let char_code = 0; char_code < 26; char_code++) {
        prev_char[0][char_code] = -1; // Sentinel value if not found
    }
    for (let i = 0; i < n; i++) {
        for (let char_code = 0; char_code < 26; char_code++) {
            prev_char[i][char_code] = (i > 0) ? prev_char[i - 1][char_code] : -1;
        }
        prev_char[i][s.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    // Base cases: single characters are palindromes
    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    // Fill DP table for lengths from 2 to n
    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            if (s[i] !== s[j]) {
                // If s[i] and s[j] are different, apply inclusion-exclusion principle
                dp[i][j] = (dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1] + MOD) % MOD;
            } else {
                // If s[i] and s[j] are the same character (let's call it 'c')
                const char_code = s.charCodeAt(i) - 'a'.charCodeAt(0);
                // Find the first occurrence of 'c' after i
                const l = next_char[i + 1][char_code];
                // Find the last occurrence of 'c' before j
                const r = prev_char[j - 1][char_code];

                if (l > r) {
                    // Case 1: No 'c' in s[i+1...j-1]
                    // Palindromes are:
                    // - All palindromes in s[i+1...j-1] (dp[i+1][j-1])
                    // - All palindromes of form 'c P c' where P is a palindrome in s[i+1...j-1] (dp[i+1][j-1])
                    // - The single character 'c' (1)
                    // - The two-character palindrome 'cc' (1)
                    dp[i][j] = (2 * dp[i + 1][j - 1] + 2) % MOD;
                } else if (l === r) {
                    // Case 2: Exactly one 'c' in s[i+1...j-1] (at index l)
                    // Palindromes are:
                    // - All palindromes in s[i+1...j-1] (dp[i+1][j-1]), which includes 'c' (s[l])
                    // - All palindromes of form 'c P c' where P is a palindrome in s[i+1...j-1] (dp[i+1][j-1])
                    // - The two-character palindrome 'cc' (1)
                    // The single 'c' is already counted in dp[i+1][j-1], so we don't add it again from the '+2'
                    dp[i][j] = (2 * dp[i + 1][j - 1] + 1) % MOD;
                } else { // l < r
                    // Case 3: Multiple 'c's in s[i+1...j-1]
                    // Palindromes are:
                    // - All palindromes in s[i+1...j-1]
                    // - All palindromes of form 'c P c' where P is a palindrome in s[i+1...j-1]
                    // - The single character 'c' and 'cc' are implicitly handled.
                    // We subtract dp[l+1][r-1] to remove duplicates. These duplicates are palindromes of the form
                    // 'c Q c' where Q is a palindrome in s[l+1...r-1]. These are counted once as 's[i] Q s[j]'
                    // and once as 's[l] Q s[r]' within dp[i+1][j-1].
                    dp[i][j] = (2 * dp[i + 1][j - 1] - dp[l + 1][r - 1] + MOD) % MOD;
                }
            }
        }
    }

    return dp[0][n - 1];
};