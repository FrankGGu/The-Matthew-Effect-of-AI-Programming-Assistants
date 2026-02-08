import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int calculate(String s) {
        Map<Character, Integer> scoreMap = new HashMap<>();
        scoreMap.put('A', 4);
        scoreMap.put('B', 3);
        scoreMap.put('C', 2);
        scoreMap.put('D', 1);
        scoreMap.put('E', 0);

        int totalScore = 0;
        String[] parts = s.split(" ");

        for (String part : parts) {
            if (scoreMap.containsKey(part.charAt(0))) {
                totalScore += scoreMap.get(part.charAt(0));
            }
        }

        return totalScore;
    }
}