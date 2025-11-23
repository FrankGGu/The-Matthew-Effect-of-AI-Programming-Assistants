class Solution {
    public int[] constructDistancedSequence(int n) {
        int len = 2 * n - 1;
        int[] result = new int[len];
        boolean[] used = new boolean[n + 1];

        return solve(result, 0, n, used) ? result : new int[0];
    }

    private boolean solve(int[] result, int index, int n, boolean[] used) {
        if (index == result.length) {
            return true;
        }

        if (result[index] != 0) {
            return solve(result, index + 1, n, used);
        }

        for (int i = n; i >= 1; i--) {
            if (!used[i]) {
                if (i == 1) {
                    result[index] = 1;
                    used[1] = true;
                    if (solve(result, index + 1, n, used)) {
                        return true;
                    }
                    result[index] = 0;
                    used[1] = false;
                } else if (index + i < result.length && result[index + i] == 0) {
                    result[index] = i;
                    result[index + i] = i;
                    used[i] = true;
                    if (solve(result, index + 1, n, used)) {
                        return true;
                    }
                    result[index] = 0;
                    result[index + i] = 0;
                    used[i] = false;
                }
            }
        }

        return false;
    }
}