class Solution {
    public boolean doesItExist(int[] derived) {
        int n = derived.length;

        // We can determine the entire 'original' array if we know the value of original[0].
        // Since original[0] can only be 0 or 1, we try both possibilities.
        // If either choice leads to a valid 'original' array, then a solution exists.
        return check(0, derived) || check(1, derived);
    }

    private boolean check(int startVal, int[] derived) {
        int n = derived.length;
        int[] original = new int[n];
        original[0] = startVal;

        // Propagate the values for original[1] through original[n-1].
        // The rule is derived[i] = original[i] ^ original[(i+1)%n].
        // For i from 0 to n-2, (i+1)%n is simply i+1.
        // So, original[i+1] = original[i] ^ derived[i].
        for (int i = 0; i < n - 1; i++) {
            original[i + 1] = original[i] ^ derived[i];
        }

        // After propagating, we have determined original[0] through original[n-1].
        // Now, we must check if the last equation holds:
        // derived[n-1] = original[n-1] ^ original[(n-1+1)%n]
        // which simplifies to derived[n-1] = original[n-1] ^ original[0].
        // If this equation holds, then the chosen startVal for original[0] leads to a valid solution.
        return derived[n - 1] == (original[n - 1] ^ original[0]);
    }
}