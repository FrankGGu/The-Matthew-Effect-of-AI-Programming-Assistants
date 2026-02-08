class Solution {
    public boolean checkValidString(String s) {
        int minOpen = 0;
        int maxOpen = 0;

        for (char c : s.toCharArray()) {
            if (c == '(') {
                minOpen++;
                maxOpen++;
            } else if (c == ')') {
                minOpen = Math.max(0, minOpen - 1);
                maxOpen--;
            } else { // c == '*'
                minOpen = Math.max(0, minOpen - 1);
                maxOpen++;
            }

            if (maxOpen < 0) {
                return false;
            }
        }

        return minOpen == 0;
    }
}