public class Solution {
    public String getPermutation(int n, int k) {
        int[] factorial = new int[n];
        boolean[] used = new boolean[n];
        StringBuilder result = new StringBuilder();

        factorial[0] = 1;
        for (int i = 1; i < n; i++) {
            factorial[i] = factorial[i - 1] * i;
        }

        k--; // convert to zero-based index
        for (int i = 0; i < n; i++) {
            int f = factorial[n - 1 - i];
            int index = k / f;
            k %= f;

            for (int j = 0; j < n; j++) {
                if (!used[j]) {
                    if (index == 0) {
                        result.append(j + 1);
                        used[j] = true;
                        break;
                    }
                    index--;
                }
            }
        }

        return result.toString();
    }
}