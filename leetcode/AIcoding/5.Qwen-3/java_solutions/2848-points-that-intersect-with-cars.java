public class Solution {

import java.util.*;

public class Solution {
    public int numberOfPoints(List<List<Integer>> points) {
        TreeSet<Integer> set = new TreeSet<>();
        for (List<Integer> point : points) {
            int start = point.get(0);
            int end = point.get(1);
            for (int i = start; i <= end; i++) {
                set.add(i);
            }
        }
        return set.size();
    }
}
}