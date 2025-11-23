public class Solution {
    public int longestSubstringWithOneMoreZeroThanOne(String s) {
        int maxLen = 0;
        int count = 0;
        int[] prefix = new int[s.length() + 1];

        for (int i = 0; i < s.length(); i++) {
            count += s.charAt(i) == '0' ? 1 : -1;
            prefix[i + 1] = count;
        }

        java.util.HashMap<Integer, Integer> map = new java.util.HashMap<>();
        map.put(0, 0);

        for (int i = 1; i <= s.length(); i++) {
            if (map.containsKey(prefix[i] - 1)) {
                int prev = map.get(prefix[i] - 1);
                maxLen = Math.max(maxLen, i - prev);
            }
            if (!map.containsKey(prefix[i])) {
                map.put(prefix[i], i);
            }
        }

        return maxLen;
    }
}