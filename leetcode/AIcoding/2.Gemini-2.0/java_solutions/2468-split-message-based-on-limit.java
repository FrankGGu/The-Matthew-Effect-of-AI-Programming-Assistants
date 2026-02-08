import java.util.*;

class Solution {
    public String[] splitMessage(String message, int limit) {
        int m = message.length();
        int k = 1;
        while (true) {
            int prefixLength = String.valueOf(k).length() + 3;
            long totalLength = 0;
            for (int i = 1; i <= k; i++) {
                totalLength += limit - (String.valueOf(i).length() + String.valueOf(k).length() + 3);
            }
            if (totalLength < m) {
                k++;
            } else {
                break;
            }
        }

        String[] result = new String[k];
        int start = 0;
        for (int i = 1; i <= k; i++) {
            int suffixLength = String.valueOf(i).length() + String.valueOf(k).length() + 3;
            int maxLength = limit - suffixLength;
            int end = Math.min(start + maxLength, m);
            result[i - 1] = message.substring(start, end) + "<" + i + "/" + k + ">";
            start = end;
        }

        return result;
    }
}