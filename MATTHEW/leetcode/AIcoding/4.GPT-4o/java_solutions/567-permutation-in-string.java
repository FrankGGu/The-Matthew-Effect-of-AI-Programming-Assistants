class Solution {
    public boolean checkInclusion(String s1, String s2) {
        int[] count = new int[26];
        for (char c : s1.toCharArray()) {
            count[c - 'a']++;
        }

        int left = 0, right = 0, len = s1.length();
        while (right < s2.length()) {
            if (count[s2.charAt(right) - 'a']-- > 0) {
                right++;
                if (right - left == len) {
                    return true;
                }
            } else if (left < right) {
                count[s2.charAt(left) - 'a']++;
                left++;
            } else {
                left++;
                right++;
            }
        }
        return false;
    }
}