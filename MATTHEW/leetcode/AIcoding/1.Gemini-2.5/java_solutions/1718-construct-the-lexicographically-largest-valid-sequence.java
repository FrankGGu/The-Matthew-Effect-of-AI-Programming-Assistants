class Solution {
    int[] ans;
    boolean[] used;
    int N;

    public int[] constructDistancedSequence(int n) {
        N = n;
        ans = new int[2 * N - 1];
        used = new boolean[N + 1]; // used[i] is true if number i has been placed

        backtrack(0);
        return ans;
    }

    private boolean backtrack(int index) {
        if (index == ans.length) {
            return true; // All positions filled, a valid sequence is found
        }

        if (ans[index] != 0) {
            // This position is already filled by a previous placement of num + num_gap
            // Move to the next position
            return backtrack(index + 1);
        }

        // Try to place numbers from N down to 1 to ensure lexicographically largest
        for (int num = N; num >= 1; num--) {
            if (!used[num]) { // If num has not been used yet
                if (num == 1) {
                    // Number 1 appears only once
                    ans[index] = 1;
                    used[1] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    // Backtrack: undo placement
                    used[1] = false;
                    ans[index] = 0;
                } else { // num > 1, appears twice with num elements between them
                    // Check if there's enough space for num and its pair
                    // 1. The second occurrence position (index + num) must be within bounds
                    // 2. The second occurrence position must be empty (0)
                    if (index + num < ans.length && ans[index + num] == 0) {
                        ans[index] = num;
                        ans[index + num] = num;
                        used[num] = true;
                        if (backtrack(index + 1)) {
                            return true;
                        }
                        // Backtrack: undo placement
                        used[num] = false;
                        ans[index] = 0;
                        ans[index + num] = 0;
                    }
                }
            }
        }
        return false; // No number could be placed at this index, backtrack further
    }
}