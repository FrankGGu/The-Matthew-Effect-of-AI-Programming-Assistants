class Solution {
    public int longestAwesome(String s) {
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);
        int mask = 0;
        int maxLen = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            mask ^= (1 << (c - '0'));
            if (map.containsKey(mask)) {
                maxLen = Math.max(maxLen, i - map.get(mask));
            } else {
                map.put(mask, i);
            }
            for (int j = 0; j < 10; j++) {
                int tempMask = mask ^ (1 << j);
                if (map.containsKey(tempMask)) {
                    maxLen = Math.max(maxLen, i - map.get(tempMask));
                }
            }
        }
        return maxLen;
    }
}