class Solution {
    public int minAddToMakeValid(String S) {
        int open = 0, close = 0;
        for (char c : S.toCharArray()) {
            if (c == '(') {
                open++;
            } else if (c == ')') {
                if (open > 0) {
                    open--;
                } else {
                    close++;
                }
            }
        }
        return open + close;
    }
}