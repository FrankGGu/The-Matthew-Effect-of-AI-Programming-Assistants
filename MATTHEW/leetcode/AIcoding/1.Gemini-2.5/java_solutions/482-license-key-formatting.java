class Solution {
    public String licenseKeyFormatting(String S, int K) {
        StringBuilder cleanKey = new StringBuilder();
        for (char c : S.toCharArray()) {
            if (c != '-') {
                cleanKey.append(Character.toUpperCase(c));
            }
        }

        if (cleanKey.length() == 0) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        int n = cleanKey.length();

        for (int i = n - 1; i >= 0; i--) {
            result.append(cleanKey.charAt(i));
            // Check if K characters have been added to the current group from the right
            // and if there are more characters to process (i > 0)
            if ((n - i) % K == 0 && i > 0) {
                result.append('-');
            }
        }

        return result.reverse().toString();
    }
}