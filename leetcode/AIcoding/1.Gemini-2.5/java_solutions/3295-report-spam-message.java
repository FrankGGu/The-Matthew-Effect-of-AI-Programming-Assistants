import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public List<Integer> reportSpamMessages(int[][] reports, int k) {
        Map<Integer, Set<Integer>> messageToReporters = new HashMap<>();

        for (int[] report : reports) {
            int reporterId = report[0];
            int messageId = report[1];
            messageToReporters.computeIfAbsent(messageId, key -> new HashSet<>()).add(reporterId);
        }

        List<Integer> spamMessageIds = new ArrayList<>();
        for (Map.Entry<Integer, Set<Integer>> entry : messageToReporters.entrySet()) {
            if (entry.getValue().size() >= k) {
                spamMessageIds.add(entry.getKey());
            }
        }

        Collections.sort(spamMessageIds);

        return spamMessageIds;
    }
}