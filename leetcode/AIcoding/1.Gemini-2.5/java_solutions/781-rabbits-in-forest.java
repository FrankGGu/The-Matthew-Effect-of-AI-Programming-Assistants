import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numRabbits(int[] answers) {
        if (answers == null || answers.length == 0) {
            return 0;
        }

        Map<Integer, Integer> counts = new HashMap<>();
        for (int answer : answers) {
            counts.put(answer, counts.getOrDefault(answer, 0) + 1);
        }

        int totalRabbits = 0;
        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            int answerValue = entry.getKey();
            int reportedCount = entry.getValue();

            int groupSize = answerValue + 1;

            // Calculate how many full groups are needed for 'reportedCount' rabbits
            // who all claim 'answerValue' others have the same color.
            // This is equivalent to ceil(reportedCount / groupSize)
            int numGroups = (reportedCount + groupSize - 1) / groupSize;

            totalRabbits += numGroups * groupSize;
        }

        return totalRabbits;
    }
}