class Solution {
    public boolean canChange(String start, String target) {
        int n = start.length();
        int i = 0, j = 0;

        while (i < n && j < n) {
            while (i < n && start.charAt(i) == '_') {
                i++;
            }
            while (j < n && target.charAt(j) == '_') {
                j++;
            }

            if (i == n || j == n) {
                break;
            }

            if (start.charAt(i) != target.charAt(j)) {
                return false;
            }

            if (start.charAt(i) == 'L') {
                if (i < j) {
                    return false;
                }
            } else { // start.charAt(i) == 'R'
                if (i > j) {
                    return false;
                }
            }

            i++;
            j++;
        }

        while (i < n && start.charAt(i) == '_') {
            i++;
        }
        while (j < n && target.charAt(j) == '_') {
            j++;
        }

        return i == n && j == n;
    }
}