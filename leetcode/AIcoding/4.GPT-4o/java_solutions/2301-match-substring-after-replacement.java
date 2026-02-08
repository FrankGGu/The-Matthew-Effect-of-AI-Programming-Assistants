class Solution {
    public boolean matchReplacement(String s, String sub, List<List<Character>> mappings) {
        Map<Character, Set<Character>> map = new HashMap<>();
        for (List<Character> mapping : mappings) {
            map.computeIfAbsent(mapping.get(0), k -> new HashSet<>()).add(mapping.get(1));
        }

        for (int i = 0; i <= s.length() - sub.length(); i++) {
            if (isMatch(s.substring(i, i + sub.length()), sub, map)) {
                return true;
            }
        }
        return false;
    }

    private boolean isMatch(String s, String sub, Map<Character, Set<Character>> map) {
        for (int i = 0; i < s.length(); i++) {
            char sc = s.charAt(i);
            char pc = sub.charAt(i);
            if (sc != pc && (!map.containsKey(pc) || !map.get(pc).contains(sc))) {
                return false;
            }
        }
        return true;
    }
}