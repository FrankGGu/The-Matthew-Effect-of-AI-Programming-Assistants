import java.util.Arrays;

class Solution {
    public String longestSubsequenceRepeatedK(String s, int k) {
        int n = s.length();
        StringBuilder sb = new StringBuilder();
        for (char c = 'z'; c >= 'a'; c--) {
            int count = 0;
            for (char ch : sb.toString().toCharArray()) {
                if (ch == c) {
                    count++;
                }
            }
            if (count > 0) continue;

            String temp = sb.toString() + c;
            if (isValid(s, temp, k)) {
                sb.append(c);
                c = 'z' + 1;
            }
        }

        String res = "";
        for (char c = 'a'; c <= 'z'; c++) {
            String temp = res + c;
            while (isValid(s, temp, k)) {
                res = temp;
                temp = res + c;
            }
        }
        return res;
    }

    private boolean isValid(String s, String sub, int k) {
        int n = s.length();
        int m = sub.length();
        int count = 0;
        int subIndex = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == sub.charAt(subIndex)) {
                subIndex++;
                if (subIndex == m) {
                    count++;
                    subIndex = 0;
                }
            }
        }
        return count >= k;
    }
}