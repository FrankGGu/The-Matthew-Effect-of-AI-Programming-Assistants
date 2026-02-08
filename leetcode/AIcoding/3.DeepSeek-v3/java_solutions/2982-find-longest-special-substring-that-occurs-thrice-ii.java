class Solution {
    public int maximumLength(String s) {
        int n = s.length();
        Map<String, Integer> freq = new HashMap<>();

        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s.charAt(j) == s.charAt(i)) {
                j++;
            }
            String substr = s.substring(i, j);
            freq.put(substr, freq.getOrDefault(substr, 0) + 1);
            i = j;
        }

        int maxLen = -1;
        for (Map.Entry<String, Integer> entry : freq.entrySet()) {
            String substr = entry.getKey();
            int count = entry.getValue();
            int len = substr.length();

            if (count >= 3) {
                maxLen = Math.max(maxLen, len);
            }
            if (len >= 3) {
                int possibleLen = len - 2;
                if (possibleLen > maxLen) {
                    int required = 3;
                    if (count >= required) {
                        maxLen = Math.max(maxLen, possibleLen);
                    }
                }
            }
            if (len >= 2) {
                int possibleLen = len - 1;
                if (possibleLen > maxLen) {
                    int required = 3;
                    if (count >= required) {
                        maxLen = Math.max(maxLen, possibleLen);
                    }
                }
            }
            if (len >= 1) {
                int possibleLen = len;
                if (possibleLen > maxLen) {
                    int required = 3;
                    if (count >= required) {
                        maxLen = Math.max(maxLen, possibleLen);
                    }
                }
            }
        }

        return maxLen;
    }
}