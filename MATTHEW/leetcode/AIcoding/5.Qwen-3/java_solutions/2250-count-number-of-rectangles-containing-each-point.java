public class Solution {

import java.util.*;

public class Solution {
    public int[] countRectangles(int[][] rectangles, int[][] points) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int[] rect : rectangles) {
            int x = rect[0];
            int y = rect[1];
            map.putIfAbsent(y, new ArrayList<>());
            map.get(y).add(x);
        }
        for (List<Integer> list : map.values()) {
            Collections.sort(list);
        }
        int[] result = new int[points.length];
        for (int i = 0; i < points.length; i++) {
            int x = points[i][0];
            int y = points[i][1];
            int count = 0;
            for (int key : map.keySet()) {
                if (key >= y) {
                    List<Integer> list = map.get(key);
                    int left = 0, right = list.size() - 1;
                    while (left <= right) {
                        int mid = left + (right - left) / 2;
                        if (list.get(mid) >= x) {
                            right = mid - 1;
                        } else {
                            left = mid + 1;
                        }
                    }
                    count += list.size() - left;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}