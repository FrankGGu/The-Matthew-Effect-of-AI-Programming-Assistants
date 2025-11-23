import java.util.HashMap;

class Solution {
    public String oddString(String[] words) {
        HashMap<String, Integer> map = new HashMap<>();
        for (String word : words) {
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i < word.length(); i++) {
                sb.append(word.charAt(i) - word.charAt(i - 1)).append(',');
            }
            String key = sb.toString();
            map.put(key, map.getOrDefault(key, 0) + 1);
        }

        for (String word : words) {
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i < word.length(); i++) {
                sb.append(word.charAt(i) - word.charAt(i - 1)).append(',');
            }
            if (map.get(sb.toString()) == 1) {
                return word;
            }
        }

        return "";
    }
}