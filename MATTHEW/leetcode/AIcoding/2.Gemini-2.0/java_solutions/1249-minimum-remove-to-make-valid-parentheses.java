class Solution {
    public String minRemoveToMakeValid(String s) {
        StringBuilder sb = new StringBuilder(s);
        int open = 0;
        for (int i = 0; i < sb.length(); i++) {
            if (sb.charAt(i) == '(') {
                open++;
            } else if (sb.charAt(i) == ')') {
                if (open == 0) {
                    sb.deleteCharAt(i);
                    i--;
                } else {
                    open--;
                }
            }
        }

        for (int i = sb.length() - 1; i >= 0; i--) {
            if (open > 0 && sb.charAt(i) == '(') {
                sb.deleteCharAt(i);
                open--;
            }
        }

        return sb.toString();
    }
}