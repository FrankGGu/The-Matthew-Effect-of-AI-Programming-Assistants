class Solution {
    public boolean matchReplacement(String s, String sub, char[][] mappings) {
        int n = s.length();
        int m = sub.length();

        if (m > n) {
            return false;
        }

        for (int i = 0; i <= n - m; i++) {
            if (canMatch(s.substring(i, i + m), sub, mappings)) {
                return true;
            }
        }

        return false;
    }

    private boolean canMatch(String s, String sub, char[][] mappings) {
        int m = sub.length();
        for (int i = 0; i < m; i++) {
            char sChar = s.charAt(i);
            char subChar = sub.charAt(i);

            if (sChar == subChar) {
                continue;
            }

            boolean found = false;
            for (char[] mapping : mappings) {
                if (mapping[0] == subChar && mapping[1] == sChar) {
                    found = true;
                    break;
                }
            }

            if (!found) {
                return false;
            }
        }

        return true;
    }
}