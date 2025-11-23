var stringRearrangement = function(n) {
    const MOD = 10**9 + 7;

    // Helper function for modular exponentiation (base^exp % MOD)
    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    // Helper function for counting strings of length n using 'k' allowed characters
    // This counts strings where specific characters (like 'l' or 't') are forbidden.
    const countStringsForbidden = (k) => power(k, n);

    // Helper function for counting strings of length n using 'k' allowed characters,
    // with the additional constraint that one specific character (like 'e') can appear 0 or 1 times.
    const countStringsAtMostOne = (k) => {
        // Case 1: The specific character appears 0 times.
        // All n positions filled with k-1 other characters.
        let term0 = power(k - 1, n);

        // Case 2: The specific character appears 1 time.
        // Choose 1 position for the specific character (n ways).
        // Fill the remaining n-1 positions with k-1 other characters.
        let term1 = (n * power(k - 1, n - 1)) % MOD;

        return (term0 + term1) % MOD;
    };

    // Total number of strings of length n using 26 lowercase English letters
    let totalStrings = power(26, n);

    // Using Inclusion-Exclusion Principle to count strings that satisfy the condition:
    // count('l') >= 1, count('e') >= 2, count('t') >= 1.
    // This is equivalent to: Total - (strings NOT satisfying the condition).
    // Let P_l be the property: string does NOT contain 'l'.
    // Let P_e be the property: string contains LESS THAN TWO 'e's (i.e., 0 or 1 'e').
    // Let P_t be the property: string does NOT contain 't'.
    // We want Total - |P_l U P_e U P_t|.

    // |P_l U P_e U P_t| = Sum(|P_i|) - Sum(|P_i intersect P_j|) + |P_l intersect P_e intersect P_t|

    // Sum of individual properties:
    // |P_l|: Strings with no 'l'. Uses 25 characters (excluding 'l').
    let count_Pl = countStringsForbidden(25);
    // |P_t|: Strings with no 't'. Uses 25 characters (excluding 't').
    let count_Pt = countStringsForbidden(25);
    // |P_e|: Strings with 0 or 1 'e'. Uses 26 characters, but 'e' is restricted.
    let count_Pe = countStringsAtMostOne(26);

    // Sum of intersections of two properties:
    // |P_l intersect P_t|: Strings with no 'l' AND no 't'. Uses 24 characters.
    let count_Pl_Pt = countStringsForbidden(24);
    // |P_l intersect P_e|: Strings with no 'l' AND 0 or 1 'e'. Uses 25 characters, 'e' restricted.
    let count_Pl_Pe = countStringsAtMostOne(25);
    // |P_e intersect P_t|: Strings with no 't' AND 0 or 1 'e'. Uses 25 characters, 'e' restricted.
    let count_Pe_Pt = countStringsAtMostOne(25);

    // Intersection of all three properties:
    // |P_l intersect P_e intersect P_t|: Strings with no 'l', no 't' AND 0 or 1 'e'. Uses 24 characters, 'e' restricted.
    let count_Pl_Pe_Pt = countStringsAtMostOne(24);

    // Calculate |P_l U P_e U P_t|
    let unionCount = 0;
    unionCount = (unionCount + count_Pl) % MOD;
    unionCount = (unionCount + count_Pt) % MOD;
    unionCount = (unionCount + count_Pe) % MOD;

    unionCount = (unionCount - count_Pl_Pt + MOD) % MOD;
    unionCount = (unionCount - count_Pl_Pe + MOD) % MOD;
    unionCount = (unionCount - count_Pe_Pt + MOD) % MOD;

    unionCount = (unionCount + count_Pl_Pe_Pt) % MOD;

    // The result is Total Strings - unionCount
    return (totalStrings - unionCount + MOD) % MOD;
};