import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int[] analyzeSubscriptions(String[] subscriptions) {
        Map<String, int[]> map = new HashMap<>();

        for (String subscription : subscriptions) {
            String[] parts = subscription.split(",");
            String userId = parts[0];
            String status = parts[1];

            if (!map.containsKey(userId)) {
                map.put(userId, new int[3]);
            }

            if (status.equals("active")) {
                map.get(userId)[0]++;
            } else if (status.equals("inactive")) {
                map.get(userId)[1]++;
            } else if (status.equals("canceled")) {
                map.get(userId)[2]++;
            }
        }

        int[] result = new int[3];
        for (int[] counts : map.values()) {
            result[0] += counts[0];
            result[1] += counts[1];
            result[2] += counts[2];
        }

        return result;
    }
}