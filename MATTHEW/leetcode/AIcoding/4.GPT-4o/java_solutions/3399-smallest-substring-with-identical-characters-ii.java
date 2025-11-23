class Solution {
    public String smallestSubstring(String s) {
        int n = s.length();
        int[] count = new int[128];
        int uniqueCount = 0;

        for (char c : s.toCharArray()) {
            if (count[c] == 0) uniqueCount++;
            count[c]++;
        }

        int left = 0, right = 0;
        int minLen = Integer.MAX_VALUE;
        String result = "";
        int[] windowCount = new int[128];
        int formed = 0;

        while (right < n) {
            char c = s.charAt(right);
            windowCount[c]++;
            if (windowCount[c] == count[c]) formed++;

            while (left <= right && formed == uniqueCount) {
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    result = s.substring(left, right + 1);
                }
                windowCount[s.charAt(left)]--;
                if (windowCount[s.charAt(left)] < count[s.charAt(left)]) formed--;
                left++;
            }
            right++;
        }

        return result;
    }
}