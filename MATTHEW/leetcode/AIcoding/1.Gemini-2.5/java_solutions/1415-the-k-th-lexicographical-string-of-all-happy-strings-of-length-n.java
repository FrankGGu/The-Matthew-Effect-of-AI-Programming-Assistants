class Solution {
    public String getHappyString(int n, int k) {
        int maxHappyStrings = 3 * (1 << (n - 1));
        if (k > maxHappyStrings) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        char prevChar = 0; 

        for (int i = 0; i < n; i++) {
            char[] possibleChars;
            if (i == 0) {
                possibleChars = new char[]{'a', 'b', 'c'};
            } else {
                if (prevChar == 'a') {
                    possibleChars = new char[]{'b', 'c'};
                } else if (prevChar == 'b') {
                    possibleChars = new char[]{'a', 'c'};
                } else { // prevChar == 'c'
                    possibleChars = new char[]{'a', 'b'};
                }
            }

            int numRemainingPositions = n - 1 - i;
            int countForNextChar = (1 << numRemainingPositions); 

            for (char currentCharOption : possibleChars) {
                if (k <= countForNextChar) {
                    sb.append(currentCharOption);
                    prevChar = currentCharOption;
                    break; 
                } else {
                    k -= countForNextChar;
                }
            }
        }
        return sb.toString();
    }
}