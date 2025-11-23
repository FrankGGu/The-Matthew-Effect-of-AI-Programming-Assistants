public class Solution {
    public String getPermutation(int n, int k) {
        int[] factorial = new int[n];
        factorial[0] = 1;
        for (int i = 1; i < n; i++) {
            factorial[i] = factorial[i - 1] * i;
        }

        StringBuilder sb = new StringBuilder();
        boolean[] used = new boolean[n];

        k--;
        for (int i = 0; i < n; i++) {
            int index = k / factorial[n - 1 - i];
            k %= factorial[n - 1 - i];

            for (int j = 0; j < n; j++) {
                if (!used[j]) {
                    if (index == 0) {
                        sb.append(j + 1);
                        used[j] = true;
                        break;
                    } else {
                        index--;
                    }
                }
            }
        }

        return sb.toString();
    }
}