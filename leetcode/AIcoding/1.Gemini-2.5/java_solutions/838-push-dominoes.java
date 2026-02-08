class Solution {
    public String pushDominoes(String dominoes) {
        int n = dominoes.length();
        int[] forces = new int[n];

        int rightForce = 0;
        for (int i = 0; i < n; i++) {
            char c = dominoes.charAt(i);
            if (c == 'R') {
                rightForce = n;
            } else if (c == 'L') {
                rightForce = 0;
            } else {
                rightForce = Math.max(0, rightForce - 1);
            }
            forces[i] += rightForce;
        }

        int leftForce = 0;
        for (int i = n - 1; i >= 0; i--) {
            char c = dominoes.charAt(i);
            if (c == 'L') {
                leftForce = n;
            } else if (c == 'R') {
                leftForce = 0;
            } else {
                leftForce = Math.max(0, leftForce - 1);
            }
            forces[i] -= leftForce;
        }

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < n; i++) {
            if (forces[i] > 0) {
                result.append('R');
            } else if (forces[i] < 0) {
                result.append('L');
            } else {
                result.append('.');
            }
        }

        return result.toString();
    }
}