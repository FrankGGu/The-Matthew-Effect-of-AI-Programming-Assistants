class Solution {
    public String minWindow(String s, String t) {
        if (t.isEmpty()) {
            return "";
        }

        int[] targetMap = new int[128];
        for (char c : t.toCharArray()) {
            targetMap[c]++;
        }

        int[] windowMap = new int[128];
        int matchCount = 0;
        int minLen = Integer.MAX_VALUE;
        int minStart = 0;
        int left = 0;

        for (int right = 0; right < s.length(); right++) {
            char rChar = s.charAt(right);
            windowMap[rChar]++;

            if (targetMap[rChar] > 0 && windowMap[rChar] <= targetMap[rChar]) {
                matchCount++;
            }

            while (matchCount == t.length()) {
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    minStart = left;
                }

                char lChar = s.charAt(left);
                if (targetMap[lChar] > 0 && windowMap[lChar] <= targetMap[lChar]) {
                    matchCount--;
                }
                windowMap[lChar]--;
                left++;
            }
        }

        if (minLen == Integer.MAX_VALUE) {
            return "";
        } else {
            return s.substring(minStart, minStart + minLen);
        }
    }
}