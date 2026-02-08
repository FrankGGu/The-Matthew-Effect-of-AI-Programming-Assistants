class Solution {
    public String minRemoveToMakeValid(String s) {
        StringBuilder sb = new StringBuilder();
        int openCount = 0;

        for (char c : s.toCharArray()) {
            if (c == '(') {
                sb.append(c);
                openCount++;
            } else if (c == ')') {
                if (openCount > 0) {
                    sb.append(c);
                    openCount--;
                }
            } else {
                sb.append(c);
            }
        }

        StringBuilder finalSb = new StringBuilder();
        int toRemoveOpen = openCount; 

        for (int i = sb.length() - 1; i >= 0; i--) {
            char c = sb.charAt(i);
            if (c == '(' && toRemoveOpen > 0) {
                toRemoveOpen--;
            } else {
                finalSb.append(c);
            }
        }

        return finalSb.reverse().toString();
    }
}