class Solution {
    public String findTheString(int[] nums) {
        StringBuilder result = new StringBuilder();
        for (int i = 25; i >= 0; i--) {
            char c = (char) ('a' + i);
            if (nums[c - 'a'] == 0) {
                result.append(c);
            }
        }
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            if (nums[c - 'a'] == 0) {
                result.append(c);
            }
        }
        return result.toString();
    }
}