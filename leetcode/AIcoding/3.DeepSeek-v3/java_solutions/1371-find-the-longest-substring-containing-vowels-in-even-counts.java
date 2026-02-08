class Solution {
    public int findTheLongestSubstring(String s) {
        int res = 0, mask = 0;
        Map<Integer, Integer> maskToIndex = new HashMap<>();
        maskToIndex.put(0, -1);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                int bit = getBit(c);
                mask ^= (1 << bit);
            }
            maskToIndex.putIfAbsent(mask, i);
            res = Math.max(res, i - maskToIndex.get(mask));
        }
        return res;
    }

    private int getBit(char c) {
        switch (c) {
            case 'a': return 0;
            case 'e': return 1;
            case 'i': return 2;
            case 'o': return 3;
            case 'u': return 4;
            default: return -1;
        }
    }
}