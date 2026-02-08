class Solution {
    public List<Integer> findAndReplacePattern(String[] words, String pattern) {
        List<Integer> result = new ArrayList<>();
        for (String word : words) {
            if (matches(word, pattern)) {
                result.add(Arrays.asList(words).indexOf(word));
            }
        }
        return result;
    }

    private boolean matches(String word, String pattern) {
        Map<Character, Character> mapWtoP = new HashMap<>();
        Map<Character, Character> mapPtoW = new HashMap<>();
        for (int i = 0; i < word.length(); i++) {
            char w = word.charAt(i);
            char p = pattern.charAt(i);
            if (!mapWtoP.containsKey(w) && !mapPtoW.containsKey(p)) {
                mapWtoP.put(w, p);
                mapPtoW.put(p, w);
            } else if (mapWtoP.getOrDefault(w, p) != p || mapPtoW.getOrDefault(p, w) != w) {
                return false;
            }
        }
        return true;
    }
}