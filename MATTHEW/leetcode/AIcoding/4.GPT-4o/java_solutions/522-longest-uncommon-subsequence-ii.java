import java.util.HashSet;

class Solution {
    public int findLUSlength(String[] strs) {
        HashSet<String> set = new HashSet<>();
        for (String str : strs) {
            set.add(str);
        }

        int maxLength = -1;
        for (String str : strs) {
            set.remove(str);
            boolean isSubsequence = false;
            for (String other : set) {
                if (isSubsequence(str, other)) {
                    isSubsequence = true;
                    break;
                }
            }
            if (!isSubsequence) {
                maxLength = Math.max(maxLength, str.length());
            }
            set.add(str);
        }

        return maxLength;
    }

    private boolean isSubsequence(String s, String t) {
        int sLen = s.length(), tLen = t.length();
        int i = 0, j = 0;
        while (i < sLen && j < tLen) {
            if (s.charAt(i) == t.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == sLen;
    }
}