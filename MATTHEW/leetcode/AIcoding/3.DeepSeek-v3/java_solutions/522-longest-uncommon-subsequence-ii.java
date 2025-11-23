class Solution {
    public int findLUSlength(String[] strs) {
        int maxLen = -1;
        for (int i = 0; i < strs.length; i++) {
            boolean isSubsequence = false;
            for (int j = 0; j < strs.length; j++) {
                if (i != j && isSubsequence(strs[i], strs[j])) {
                    isSubsequence = true;
                    break;
                }
            }
            if (!isSubsequence) {
                maxLen = Math.max(maxLen, strs[i].length());
            }
        }
        return maxLen;
    }

    private boolean isSubsequence(String a, String b) {
        int i = 0, j = 0;
        while (i < a.length() && j < b.length()) {
            if (a.charAt(i) == b.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == a.length();
    }
}