import java.util.*;

public class Solution {
    public int[] fireworksDisplay(int[][] positions, int[] heights) {
        int n = positions.length;
        int[] result = new int[n];
        List<int[]> events = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            events.add(new int[]{positions[i][0], heights[i], 1}); // Start event
            events.add(new int[]{positions[i][1], heights[i], -1}); // End event
        }

        Collections.sort(events, (a, b) -> a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);

        TreeMap<Integer, Integer> heightCount = new TreeMap<>();

        for (int[] event : events) {
            int type = event[2];
            int height = event[1];

            if (type == 1) {
                heightCount.put(height, heightCount.getOrDefault(height, 0) + 1);
            } else {
                if (heightCount.get(height) == 1) {
                    heightCount.remove(height);
                } else {
                    heightCount.put(height, heightCount.get(height) - 1);
                }
            }

            result[Arrays.asList(positions).indexOf(new int[]{event[0], type})] = heightCount.isEmpty() ? 0 : heightCount.lastKey();
        }

        return result;
    }
}