class Solution {
    public boolean placeWordInCrossword(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;
        int wordLen = word.length();
        String reversedWord = new StringBuilder(word).reverse().toString();

        // Check horizontal placements
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Skip if current cell is blocked
                if (board[i][j] == '#') {
                    continue;
                }

                // Check if this is the start of a potential horizontal segment
                // A segment starts if it's at the beginning of the row (j == 0)
                // or if the previous cell was blocked (board[i][j-1] == '#')
                if (j == 0 || board[i][j - 1] == '#') {
                    int k = j;
                    // Find the end of the current segment
                    while (k < n && board[i][k] != '#') {
                        k++;
                    }
                    int segmentLen = k - j;

                    if (segmentLen == wordLen) {
                        char[] segment = new char[wordLen];
                        for (int x = 0; x < wordLen; x++) {
                            segment[x] = board[i][j + x];
                        }
                        if (checkFit(segment, word) || checkFit(segment, reversedWord)) {
                            return true;
                        }
                    }
                }
            }
        }

        // Check vertical placements
        for (int j = 0; j < n; j++) { // Iterate columns first for vertical segments
            for (int i = 0; i < m; i++) {
                // Skip if current cell is blocked
                if (board[i][j] == '#') {
                    continue;
                }

                // Check if this is the start of a potential vertical segment
                // A segment starts if it's at the beginning of the column (i == 0)
                // or if the cell above was blocked (board[i-1][j] == '#')
                if (i == 0 || board[i - 1][j] == '#') {
                    int k = i;
                    // Find the end of the current segment
                    while (k < m && board[k][j] != '#') {
                        k++;
                    }
                    int segmentLen = k - i;

                    if (segmentLen == wordLen) {
                        char[] segment = new char[wordLen];
                        for (int x = 0; x < wordLen; x++) {
                            segment[x] = board[i + x][j];
                        }
                        if (checkFit(segment, word) || checkFit(segment, reversedWord)) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }

    // Helper method to check if a word can fit into a given segment of the board.
    // segment: characters from the board for a potential slot (must have length == wordToCheck.length())
    // wordToCheck: either the original word or its reversed version
    // Returns true if wordToCheck fits, false otherwise.
    private static boolean checkFit(char[] segment, String wordToCheck) {
        for (int k = 0; k < segment.length; k++) {
            // If the board cell is not empty (' ') and does not match the word character,
            // then the word cannot be placed.
            if (segment[k] != ' ' && segment[k] != wordToCheck.charAt(k)) {
                return false;
            }
        }
        return true;
    }
}