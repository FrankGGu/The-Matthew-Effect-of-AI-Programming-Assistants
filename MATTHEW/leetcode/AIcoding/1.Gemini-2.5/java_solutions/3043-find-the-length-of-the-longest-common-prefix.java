class Solution {
    public int longestCommonPrefix(String[] strs) {
        if (strs == null || strs.length == 0) {
            return 0;
        }
        if (strs.length == 1) {
            return strs[0].length();
        }

        int minLength = strs[0].length();

        for (int i = 0; i < minLength; i++) {
            char currentChar = strs[0].charAt(i);
            for (int j = 1; j < strs.length; j++) {
                if (i >= strs[j].length() || strs[j].charAt(i) != currentChar) {
                    return i;
                }
            }
        }

        return minLength;
    }
}