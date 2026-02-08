import java.util.Arrays;

public class Solution {
    public String shortestUncommonSubstring(String[] A) {
        Arrays.sort(A);
        String s1 = A[0];
        String s2 = A[1];
        String result = "";

        for (int i = 0; i < s1.length(); i++) {
            for (int j = 1; j <= s1.length() - i; j++) {
                String sub = s1.substring(i, i + j);
                if (isUncommon(sub, A)) {
                    if (result.isEmpty() || sub.length() < result.length()) {
                        result = sub;
                    }
                }
            }
        }

        return result;
    }

    private boolean isUncommon(String sub, String[] A) {
        for (String s : A) {
            if (s.contains(sub) && s != sub) {
                return false;
            }
        }
        return true;
    }
}