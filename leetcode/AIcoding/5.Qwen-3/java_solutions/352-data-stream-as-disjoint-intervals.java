public class Solution {

import java.util.*;

public class Solution {
    private TreeSet<Integer> intervals;

    public Solution() {
        intervals = new TreeSet<>();
    }

    public void addNum(int value) {
        if (intervals.contains(value)) {
            return;
        }
        Integer floor = intervals.floor(value);
        Integer ceiling = intervals.ceiling(value);
        if (floor != null && ceiling != null && floor + 1 <= value - 1 && value + 1 <= ceiling - 1) {
            intervals.add(value);
        } else if (floor != null && floor + 1 == value) {
            intervals.remove(floor);
            intervals.add(floor + 1);
        } else if (ceiling != null && ceiling - 1 == value) {
            intervals.remove(ceiling);
            intervals.add(ceiling - 1);
        } else {
            intervals.add(value);
        }
    }

    public List<int[]> getIntervals() {
        List<int[]> result = new ArrayList<>();
        Iterator<Integer> it = intervals.iterator();
        if (!it.hasNext()) {
            return result;
        }
        int start = it.next();
        int end = start;
        while (it.hasNext()) {
            int current = it.next();
            if (current == end + 1) {
                end = current;
            } else {
                result.add(new int[]{start, end});
                start = current;
                end = current;
            }
        }
        result.add(new int[]{start, end});
        return result;
    }
}
}