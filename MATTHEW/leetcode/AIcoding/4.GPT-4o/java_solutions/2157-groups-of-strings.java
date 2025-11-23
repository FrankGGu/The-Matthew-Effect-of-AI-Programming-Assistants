import java.util.*;

public class Solution {
    public List<List<String>> groupStrings(String[] strings) {
        Map<String, List<String>> map = new HashMap<>();

        for (String str : strings) {
            String key = getKey(str);
            map.computeIfAbsent(key, k -> new ArrayList<>()).add(str);
        }

        return new ArrayList<>(map.values());
    }

    private String getKey(String str) {
        StringBuilder key = new StringBuilder();
        int offset = str.charAt(0) - 'a';

        for (char c : str.toCharArray()) {
            char shifted = (char) ((c - 'a' - offset + 26) % 26 + 'a');
            key.append(shifted);
        }

        return key.toString();
    }
}