class Solution {
    public int similarPairs(String[] words) {
        Map<String, Integer> map = new HashMap<>();
        for (String word : words) {
            boolean[] chars = new boolean[26];
            for (char c : word.toCharArray()) {
                chars[c - 'a'] = true;
            }
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 26; i++) {
                if (chars[i]) {
                    sb.append((char) ('a' + i));
                }
            }
            String key = sb.toString();
            map.put(key, map.getOrDefault(key, 0) + 1);
        }
        int res = 0;
        for (int count : map.values()) {
            res += count * (count - 1) / 2;
        }
        return res;
    }
}