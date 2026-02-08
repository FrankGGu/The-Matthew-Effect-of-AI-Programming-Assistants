class Solution {
    public String pushDominoes(String dominoes) {
        char[] arr = dominoes.toCharArray();
        int n = arr.length;
        int[] forces = new int[n];

        int force = 0;
        for (int i = 0; i < n; i++) {
            if (arr[i] == 'R') {
                force = n; // A large positive force for 'R'
            } else if (arr[i] == 'L') {
                force = 0; // Reset force for 'L'
            } else {
                force = Math.max(force - 1, 0);
            }
            forces[i] += force;
        }

        force = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (arr[i] == 'L') {
                force = n; // A large negative force for 'L'
            } else if (arr[i] == 'R') {
                force = 0; // Reset force for 'R'
            } else {
                force = Math.max(force - 1, 0);
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