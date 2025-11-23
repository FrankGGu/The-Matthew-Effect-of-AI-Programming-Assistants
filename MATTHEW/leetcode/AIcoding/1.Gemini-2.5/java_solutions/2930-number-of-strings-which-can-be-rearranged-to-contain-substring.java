class Solution {
    private static final int MOD = 1_000_000_007;

    private long power(long base, int exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    public int stringCount(int n) {
        // Total number of strings of length n using 26 lowercase English letters
        long totalStrings = power(26, n);

        // We want to count strings that contain at least one 'a', at least one 'b', and at least one 'c'.
        // We use the Principle of Inclusion-Exclusion.
        // Let S be the set of all strings of length n.
        // Let P_a be the property that a string does NOT contain 'a'.
        // Let P_b be the property that a string does NOT contain 'b'.
        // Let P_c be the property that a string does NOT contain 'c'.
        // We want to find |S| - |P_a U P_b U P_c|.
        // |P_a U P_b U P_c| = Sum(|P_i|) - Sum(|P_i intersect P_j|) + Sum(|P_i intersect P_j intersect P_k|)

        // Sum(|P_i|): Strings missing one specific character.
        // There are 3 such cases (missing 'a', missing 'b', missing 'c').
        // Each case involves strings formed from 25 characters.
        long missingOneChar = (3L * power(25, n)) % MOD;

        // Sum(|P_i intersect P_j|): Strings missing two specific characters.
        // There are 3 such cases (missing 'a' and 'b', missing 'a' and 'c', missing 'b' and 'c').
        // Each case involves strings formed from 24 characters.
        long missingTwoChars = (3L * power(24, n)) % MOD;

        // Sum(|P_i intersect P_j intersect P_k|): Strings missing three specific characters.
        // There is 1 such case (missing 'a', 'b', and 'c').
        // This case involves strings formed from 23 characters.
        long missingThreeChars = power(23, n);

        // Calculate |P_a U P_b U P_c| (number of strings that DO NOT contain at least one 'a', 'b', and 'c')
        long notContainingABC = (missingOneChar - missingTwoChars + MOD) % MOD;
        notContainingABC = (notContainingABC + missingThreeChars) % MOD;

        // The final result is total strings minus those that do not contain 'a', 'b', and 'c'
        long result = (totalStrings - notContainingABC + MOD) % MOD;

        return (int) result;
    }
}