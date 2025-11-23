import java.util.HashMap;
import java.util.Map;

class WordFilter {
    Map<String, Integer> map;

    public WordFilter(String[] words) {
        map = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            for (int j = 0; j <= word.length(); j++) {
                String prefix = word.substring(0, j);
                for (int k = 0; k <= word.length(); k++) {
                    String suffix = word.substring(word.length() - k);
                    map.put(prefix + "#" + suffix, i);
                }
            }
        }
    }

    public int f(String pref, String suff) {
        return map.getOrDefault(pref + "#" + suff, -1);
    }
}