import java.util.HashMap;
import java.util.HashSet;

class Solution {
    public boolean wordPattern(String pattern, String s) {
        String[] words = s.split(" ");
        if (pattern.length() != words.length) return false;

        HashMap<Character, String> map = new HashMap<>();
        HashSet<String> set = new HashSet<>();

        for (int i = 0; i < pattern.length(); i++) {
            char c = pattern.charAt(i);
            String word = words[i];

            if (!map.containsKey(c)) {
                if (set.contains(word)) return false;
                map.put(c, word);
                set.add(word);
            } else {
                if (!map.get(c).equals(word)) return false;
            }
        }
        return true;
    }
}