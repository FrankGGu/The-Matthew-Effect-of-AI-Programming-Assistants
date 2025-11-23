public class Solution {
    public String pushDominoes(String dominoes) {
        int n = dominoes.length();
        char[] result = dominoes.toCharArray();
        int[] force = new int[n];

        int f = 0;
        for (int i = 0; i < n; i++) {
            if (dominoes.charAt(i) == 'R') {
                f = 1;
            } else if (dominoes.charAt(i) == 'L') {
                f = 0;
            } else {
                if (f > 0) {
                    force[i] += f;
                    f++;
                }
            }
        }

        f = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (dominoes.charAt(i) == 'L') {
                f = 1;
            } else if (dominoes.charAt(i) == 'R') {
                f = 0;
            } else {
                if (f > 0) {
                    force[i] -= f;
                    f++;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (force[i] > 0) {
                result[i] = 'R';
            } else if (force[i] < 0) {
                result[i] = 'L';
            }
        }

        return new String(result);
    }
}