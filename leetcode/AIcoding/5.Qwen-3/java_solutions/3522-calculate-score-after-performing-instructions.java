public class Solution {

import java.util.*;

public class Solution {
    public int calculateScore(String s, int[] knowledge) {
        Map<String, String> map = new HashMap<>();
        for (int i = 0; i < knowledge.length; i += 2) {
            map.put(s.substring(knowledge[i], knowledge[i + 1]), s.substring(knowledge[i + 1], knowledge[i + 2]));
        }
        int score = 0;
        int i = 0;
        while (i < s.length()) {
            if (s.charAt(i) == '(') {
                int j = i + 1;
                while (j < s.length() && s.charAt(j) != ')') {
                    j++;
                }
                String key = s.substring(i + 1, j);
                String value = map.getOrDefault(key, "");
                score += value.length();
                i = j + 1;
            } else {
                score++;
                i++;
            }
        }
        return score;
    }
}
}