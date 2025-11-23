class Solution {
    public int[] constructDistancedSequence(int n) {
        int[] res = new int[2 * n - 1];
        boolean[] used = new boolean[n + 1];
        solve(res, used, 0, n);
        return res;
    }

    private boolean solve(int[] res, boolean[] used, int index, int n) {
        if (index == res.length) {
            return true;
        }
        if (res[index] != 0) {
            return solve(res, used, index + 1, n);
        }
        for (int i = n; i >= 1; i--) {
            if (!used[i]) {
                if (i == 1) {
                    res[index] = 1;
                    used[1] = true;
                    if (solve(res, used, index + 1, n)) {
                        return true;
                    }
                    res[index] = 0;
                    used[1] = false;
                } else if (index + i < res.length && res[index + i] == 0) {
                    res[index] = i;
                    res[index + i] = i;
                    used[i] = true;
                    if (solve(res, used, index + 1, n)) {
                        return true;
                    }
                    res[index] = 0;
                    res[index + i] = 0;
                    used[i] = false;
                }
            }
        }
        return false;
    }
}