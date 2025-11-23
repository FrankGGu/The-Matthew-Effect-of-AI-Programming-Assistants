class Solution {
    public boolean isFaultyKeyboard(String typed, String printed) {
        int i = 0, j = 0;
        while (i < typed.length() && j < printed.length()) {
            if (typed.charAt(i) == printed.charAt(j)) {
                i++;
                j++;
            } else if (j > 0 && printed.charAt(j) == printed.charAt(j - 1)) {
                j++;
            } else {
                return false;
            }
        }
        while (j < printed.length() && printed.charAt(j) == printed.charAt(j - 1)) {
            j++;
        }
        return i == typed.length() && j == printed.length();
    }
}