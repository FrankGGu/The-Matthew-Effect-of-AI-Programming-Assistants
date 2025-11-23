class Solution {
    public int[] smallestLexicographical(int n) {
        int[] result = new int[2 * n - 1];
        boolean[] used = new boolean[n + 1];

        for (int i = 0; i < 2 * n - 1; i++) {
            for (int j = n; j >= 1; j--) {
                if (!used[j] && (j == 1 || i + j < 2 * n - 1 && result[i + j] == 0)) {
                    result[i] = j;
                    used[j] = true;
                    if (j > 1) {
                        result[i + j] = j;
                    }
                    break;
                }
            }
        }

        return result;
    }
}