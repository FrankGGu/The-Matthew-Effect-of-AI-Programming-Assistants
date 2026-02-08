class Solution {
    public int lengthOfLongestSubstring(String s) {
        int n = s.length(), maxLen = 0;
        HashMap<Character, Integer> map = new HashMap<>();
        for (int right = 0, left = 0; right < n; right++) {
            if (map.containsKey(s.charAt(right))) {
                left = Math.max(map.get(s.charAt(right)) + 1, left);
            }
            map.put(s.charAt(right), right);
            maxLen = Math.max(maxLen, right - left + 1);
        }
        return maxLen;
    }
}