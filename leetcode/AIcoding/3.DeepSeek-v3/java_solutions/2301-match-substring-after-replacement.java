class Solution {
    public boolean matchReplacement(String s, String sub, char[][] mappings) {
        Map<Character, Set<Character>> map = new HashMap<>();
        for (char[] mapping : mappings) {
            char oldChar = mapping[0];
            char newChar = mapping[1];
            map.putIfAbsent(oldChar, new HashSet<>());
            map.get(oldChar).add(newChar);
        }

        int n = s.length();
        int m = sub.length();

        for (int i = 0; i <= n - m; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                char sChar = s.charAt(i + j);
                char subChar = sub.charAt(j);
                if (sChar == subChar) {
                    continue;
                }
                if (!map.containsKey(subChar) || !map.get(subChar).contains(sChar)) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return true;
            }
        }
        return false;
    }
}