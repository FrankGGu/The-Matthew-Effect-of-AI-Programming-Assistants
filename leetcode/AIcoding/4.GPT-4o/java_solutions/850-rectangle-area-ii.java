import java.util.*;

public class Solution {
    public int rectangleArea(int[][] rectangles) {
        final int MOD = 1000000007;
        TreeMap<Integer, List<int[]>> map = new TreeMap<>();
        for (int[] rect : rectangles) {
            map.putIfAbsent(rect[0], new ArrayList<>());
            map.get(rect[0]).add(new int[]{rect[1], rect[3], 1});
            map.putIfAbsent(rect[2], new ArrayList<>());
            map.get(rect[2]).add(new int[]{rect[1], rect[3], -1});
        }

        long area = 0;
        int prevX = 0;
        List<int[]> active = new ArrayList<>();

        for (Map.Entry<Integer, List<int[]>> entry : map.entrySet()) {
            int x = entry.getKey();
            if (active.size() > 0) {
                area = (area + (long) (x - prevX) * computeLength(active)) % MOD;
            }
            for (int[] event : entry.getValue()) {
                if (event[2] == 1) {
                    active.add(new int[]{event[0], event[1]});
                } else {
                    active.removeIf(a -> a[0] == event[0] && a[1] == event[1]);
                }
            }
            prevX = x;
        }
        return (int) area;
    }

    private long computeLength(List<int[]> intervals) {
        Collections.sort(intervals, Comparator.comparingInt(a -> a[0]));
        long length = 0;
        int currentStart = -1, currentEnd = -1;

        for (int[] interval : intervals) {
            if (interval[0] > currentEnd) {
                length += currentEnd - currentStart;
                currentStart = interval[0];
                currentEnd = interval[1];
            } else {
                currentEnd = Math.max(currentEnd, interval[1]);
            }
        }
        length += currentEnd - currentStart;
        return length;
    }
}