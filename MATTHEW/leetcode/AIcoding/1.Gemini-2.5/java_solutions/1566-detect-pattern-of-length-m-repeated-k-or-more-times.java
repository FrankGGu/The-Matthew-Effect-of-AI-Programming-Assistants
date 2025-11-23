class Solution {
    public boolean containsPattern(int[] arr, int m, int k) {
        int n = arr.length;

        for (int i = 0; i <= n - m * k; i++) {
            int repetitions = 0;
            for (int j = 0; j < k; j++) {
                boolean match = true;
                for (int p = 0; p < m; p++) {
                    if (arr[i + p] != arr[i + j * m + p]) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    repetitions++;
                } else {
                    break;
                }
            }
            if (repetitions == k) {
                return true;
            }
        }
        return false;
    }
}