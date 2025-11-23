public class Solution {

import java.util.*;

public class FindStudentsWhoImproved {
    public static List<String> getStudentsWithImprovement(List<List<Integer>> reports) {
        Map<String, int[]> studentScores = new HashMap<>();

        for (List<Integer> report : reports) {
            String name = report.get(0);
            int score = report.get(1);

            if (!studentScores.containsKey(name)) {
                studentScores.put(name, new int[]{score, score});
            } else {
                int[] scores = studentScores.get(name);
                scores[0] = Math.min(scores[0], score);
                scores[1] = Math.max(scores[1], score);
            }
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, int[]> entry : studentScores.entrySet()) {
            int minScore = entry.getValue()[0];
            int maxScore = entry.getValue()[1];
            if (maxScore > minScore) {
                result.add(entry.getKey());
            }
        }

        return result;
    }

    public static void main(String[] args) {
        List<List<Integer>> reports = Arrays.asList(
            Arrays.asList("Alice", 85),
            Arrays.asList("Bob", 70),
            Arrays.asList("Alice", 90),
            Arrays.asList("Charlie", 80),
            Arrays.asList("Bob", 75),
            Arrays.asList("Charlie", 85)
        );

        List<String> result = getStudentsWithImprovement(reports);
        System.out.println(result);
    }
}
}