import java.util.*;

class Solution {
    public String mostCommonWord(String paragraph, String[] banned) {
        Map<String, Integer> count = new HashMap<>();
        Set<String> bannedSet = new HashSet<>(Arrays.asList(banned));
        StringBuilder sb = new StringBuilder();
        for (char c : paragraph.toCharArray()) {
            if (Character.isLetter(c)) {
                sb.append(Character.toLowerCase(c));
            } else {
                if (sb.length() > 0) {
                    String word = sb.toString();
                    if (!bannedSet.contains(word)) {
                        count.put(word, count.getOrDefault(word, 0) + 1);
                    }
                    sb.setLength(0);
                }
            }
        }
        if (sb.length() > 0) {
            String word = sb.toString();
            if (!bannedSet.contains(word)) {
                count.put(word, count.getOrDefault(word, 0) + 1);
            }
        }
        String result = "";
        int maxCount = 0;
        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            if (entry.getValue() > maxCount) {
                maxCount = entry.getValue();
                result = entry.getKey();
            }
        }
        return result;
    }
}