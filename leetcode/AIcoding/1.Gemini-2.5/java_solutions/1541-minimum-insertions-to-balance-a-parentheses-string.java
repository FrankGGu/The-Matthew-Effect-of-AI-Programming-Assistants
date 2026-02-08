class Solution {
    public int minInsertions(String s) {
        int insertions = 0;
        int openParentheses = 0; // Tracks the number of open '(' that are waiting for '))'

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            if (c == '(') {
                openParentheses++;
            } else { // c == ')'
                // If there's an open '(', this ')' can potentially close it.
                if (openParentheses > 0) {
                    openParentheses--;
                } else {
                    // No open '('. We need to insert an opening '('.
                    insertions++;
                }

                // Now, this ')' (either matched with an existing '(' or with an inserted '(')
                // is the first ')' of the required ')))' pair.
                // We need to check for the second ')'.
                if (i + 1 < s.length() && s.charAt(i + 1) == ')') {
                    // Found the second ')'. Consume it by advancing 'i'.
                    i++;
                } else {
                    // Second ')' is missing. We need to insert one.
                    insertions++;
                }
            }
        }

        // After iterating through the string, any remaining openParentheses
        // still need to be closed. Each '(' requires two ')' insertions.
        insertions += openParentheses * 2;

        return insertions;
    }
}