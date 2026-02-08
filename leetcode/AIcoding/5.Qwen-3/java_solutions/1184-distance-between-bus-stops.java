public class Solution {

import java.util.*;

public class Solution {
    public int distanceBetweenBusStops(int[] distance, int start, int end) {
        if (start == end) return 0;
        int n = distance.length;
        int clockwise = 0;
        int counterClockwise = 0;
        if (start < end) {
            for (int i = start; i < end; i++) {
                clockwise += distance[i];
            }
            for (int i = end; i < n; i++) {
                counterClockwise += distance[i];
            }
            for (int i = 0; i < start; i++) {
                counterClockwise += distance[i];
            }
        } else {
            for (int i = start; i < n; i++) {
                clockwise += distance[i];
            }
            for (int i = 0; i < end; i++) {
                clockwise += distance[i];
            }
            for (int i = end; i < start; i++) {
                counterClockwise += distance[i];
            }
        }
        return Math.min(clockwise, counterClockwise);
    }
}
}