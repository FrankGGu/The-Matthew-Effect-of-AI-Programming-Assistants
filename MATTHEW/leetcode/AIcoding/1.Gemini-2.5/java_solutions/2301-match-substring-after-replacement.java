class Solution {
    public boolean matchReplacement(String s, String substring, char[][] mappings) {
        boolean[][] canReplace = new boolean[128][128]; // Assuming ASCII characters

        // A character can always replace itself
        for (int i = 0; i < 128; i++) {
            canReplace[i][i] = true;
        }

        // Apply given mappings
        for (char[] mapping : mappings) {
            canReplace[mapping[0]][mapping[1]] = true;
        }

        int n = s.length();
        int m = substring.length();

        // Iterate through all possible starting positions in s
        for (int i = 0; i <= n - m; i++) {
            boolean currentMatch = true;
            // Check if substring matches s.substring(i, i + m) with replacements
            for (int j = 0; j < m; j++) {
                char sChar = s.charAt(i + j);
                char subChar = substring.charAt(j);

                if (!canReplace[sChar][subChar]) {
                    currentMatch = false;
                    break;
                }
            }
            if (currentMatch) {
                return true; // Found a match
            }
        }

        return false; // No match found
    }
}