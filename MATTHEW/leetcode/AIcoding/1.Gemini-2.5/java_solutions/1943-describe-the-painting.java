import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    static class Event {
        int coord;
        int color;
        int type;

        Event(int coord, int color, int type) {
            this.coord = coord;
            this.color = color;
            this.type = type;
        }
    }

    public List<List<Long>> describeThePainting(int[][] paintings) {
        List<Event> events = new ArrayList<>();
        for (int[] p : paintings) {
            int start = p[0];
            int end = p[1];
            int color = p[2];
            events.add(new Event(start, color, 1));
            events.add(new Event(end, color, -1));
        }

        Collections.sort(events, (a, b) -> {
            if (a.coord != b.coord) {
                return Integer.compare(a.coord, b.coord);
            }
            return Integer.compare(a.type, b.type);
        });

        Map<Integer, Long> activeColorCounts = new HashMap<>();
        Map<Integer, Long> resultTotals = new HashMap<>();

        long prevCoord = 0;

        if (!events.isEmpty()) {
            prevCoord = events.get(0).coord;
        }

        for (Event event : events) {
            long currentCoord = event.coord;

            if (currentCoord > prevCoord) {
                for (Map.Entry<Integer, Long> entry : activeColorCounts.entrySet()) {
                    int color = entry.getKey();
                    long count = entry.getValue();
                    if (count > 0) { 
                        resultTotals.merge(color, (currentCoord - prevCoord), Long::sum);
                    }
                }
            }

            activeColorCounts.merge(event.color, (long) event.type, Long::sum);

            if (activeColorCounts.get(event.color) == 0) {
                activeColorCounts.remove(event.color);
            }

            prevCoord = currentCoord;
        }

        List<List<Long>> result = new ArrayList<>();
        List<Integer> sortedColors = new ArrayList<>(resultTotals.keySet());
        Collections.sort(sortedColors); 

        for (int color : sortedColors) {
            result.add(Arrays.asList((long) color, resultTotals.get(color)));
        }

        return result;
    }
}