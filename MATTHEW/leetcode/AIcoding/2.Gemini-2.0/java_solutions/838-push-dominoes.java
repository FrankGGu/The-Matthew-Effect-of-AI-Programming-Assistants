class Solution {
    public String pushDominoes(String dominoes) {
        char[] s = dominoes.toCharArray();
        int n = s.length;
        int[] forces = new int[n];

        int force = 0;
        for (int i = 0; i < n; i++) {
            if (s[i] == 'R') {
                force = n;
            } else if (s[i] == 'L') {
                force = 0;
            } else {
                force = Math.max(0, force - 1);
            }
            forces[i] += force;
        }

        force = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (s[i] == 'L') {
                force = n;
            } else if (s[i] == 'R') {
                force = 0;
            } else {
                force = Math.max(0, force - 1);
            }
            forces[i] -= force;
        }

        StringBuilder result = new StringBuilder();
        for (int f : forces) {
            if (f > 0) {
                result.append('R');
            } else if (f < 0) {
                result.append('L');
            } else {
                result.append('.');
            }
        }

        return result.toString();
    }
}