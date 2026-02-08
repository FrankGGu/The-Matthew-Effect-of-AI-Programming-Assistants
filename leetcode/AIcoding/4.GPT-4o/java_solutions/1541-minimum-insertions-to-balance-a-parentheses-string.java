class Solution {
    public int minInsertions(String s) {
        int insertions = 0, open = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '(') {
                open++;
            } else {
                if (open > 0) {
                    open--;
                } else {
                    insertions++;
                }
                if (i + 1 < s.length() && s.charAt(i) == ')') {
                    i++;
                } else {
                    insertions++;
                }
            }
        }
        return insertions + open * 2;
    }
}