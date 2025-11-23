import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private boolean isSubsequence(String s, String t) {
        int i = 0, j = 0;
        while (i < s.length() && j < t.length()) {
            if (s.charAt(i) == t.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == s.length();
    }

    public int findLUSlength(String[] strs) {
        Arrays.sort(strs, new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                return s2.length() - s1.length();
            }
        });

        for (int i = 0; i < strs.length; i++) {
            String currentStr = strs[i];
            boolean isUncommon = true;

            for (int j = 0; j < strs.length; j++) {
                if (i == j) {
                    continue;
                }
                if (isSubsequence(currentStr, strs[j])) {
                    isUncommon = false;
                    break;
                }
            }

            if (isUncommon) {
                return currentStr.length();
            }
        }

        return -1;
    }
}