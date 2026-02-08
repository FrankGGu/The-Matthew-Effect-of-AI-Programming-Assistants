class Solution {
    public boolean pyramidTransition(String bottom, List<String> allowed) {
        Map<String, List<Character>> map = new HashMap<>();
        for (String s : allowed) {
            String key = s.substring(0, 2);
            if (!map.containsKey(key)) {
                map.put(key, new ArrayList<>());
            }
            map.get(key).add(s.charAt(2));
        }
        return dfs(bottom, "", map);
    }

    private boolean dfs(String current, String next, Map<String, List<Character>> map) {
        if (current.length() == 1) {
            return true;
        }
        if (next.length() + 1 == current.length()) {
            return dfs(next, "", map);
        }
        int pos = next.length();
        String key = current.substring(pos, pos + 2);
        if (!map.containsKey(key)) {
            return false;
        }
        for (char c : map.get(key)) {
            if (dfs(current, next + c, map)) {
                return true;
            }
        }
        return false;
    }
}