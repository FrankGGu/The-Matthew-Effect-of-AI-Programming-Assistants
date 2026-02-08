import java.util.*;

class Solution {
    public int countBuildings(int[][] buildings) {
        List<int[]> events = new ArrayList<>();
        for (int[] building : buildings) {
            events.add(new int[]{building[0], building[2]}); // start event
            events.add(new int[]{building[1], -building[2]}); // end event
        }
        Collections.sort(events, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        int count = 0, currentHeight = 0, prevX = 0;
        for (int[] event : events) {
            int x = event[0], height = event[1];
            if (currentHeight > 0) {
                count += x - prevX;
            }
            currentHeight += height;
            prevX = x;
        }
        return count;
    }
}