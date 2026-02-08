class Solution {
    public String smallestSubstring(String s) {
        if (s == null || s.length() == 0) {
            return "";
        }

        int n = s.length();
        int left = 0;
        int minLen = Integer.MAX_VALUE;
        int start = 0;
        int[] count = new int[256];
        int distinct = 0;

        for (int right = 0; right < n; right++) {
            if (count[s.charAt(right)] == 0) {
                distinct++;
            }
            count[s.charAt(right)]++;

            while (distinct == 1) {
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    start = left;
                }
                count[s.charAt(left)]--;
                if (count[s.charAt(left)] == 0) {
                    distinct--;
                }
                left++;
            }
        }

        return minLen == Integer.MAX_VALUE ? "" : s.substring(start, start + minLen);
    }
}