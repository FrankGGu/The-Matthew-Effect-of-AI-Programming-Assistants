class Solution {
    public boolean canForm(String typed, String original) {
        int i = 0, j = 0;
        int n = typed.length(), m = original.length();

        while (i < n && j < m) {
            if (typed.charAt(i) == original.charAt(j)) {
                i++;
                j++;
            } else if (j > 0 && original.charAt(j - 1) == original.charAt(j)) {
                j++;
            } else {
                return false;
            }
        }

        while (j < m && original.charAt(j) == original.charAt(j - 1)) {
            j++;
        }

        return j == m && i == n;
    }
}