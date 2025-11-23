class Solution {
    public int reinitializePermutation(int n) {
        int operations = 0;
        int currentPositionOfOne = 1; // We track the position of the value '1'.
                                      // Initially, value '1' is at index 1.

        // The transformation rule defines where the value at perm[j] moves to.
        // If the value 'v' is at perm[j], after one operation, it moves to arr[i].
        // Case 1: i is even. arr[i] = perm[i/2]. So, if perm[j] = v, then j = i/2, which means i = 2*j.
        // Case 2: i is odd. arr[i] = perm[n/2 + (i-1)/2]. So, if perm[j] = v, then j = n/2 + (i-1)/2.
        // This simplifies to 2*j = n + i - 1, which means i = 2*j - n + 1.

        // So, if the value '1' is currently at index 'j' (currentPositionOfOne),
        // its new index 'i' after one operation will be:
        // if j < n/2, then i = 2*j. (This corresponds to i being even, and i < n)
        // if j >= n/2, then i = 2*j - n + 1. (This corresponds to i being odd, and i < n)

        do {
            if (currentPositionOfOne < n / 2) {
                currentPositionOfOne *= 2;
            } else {
                currentPositionOfOne = 2 * currentPositionOfOne - n + 1;
            }
            operations++;
        } while (currentPositionOfOne != 1); // Continue until the value '1' returns to its initial position

        return operations;
    }
}