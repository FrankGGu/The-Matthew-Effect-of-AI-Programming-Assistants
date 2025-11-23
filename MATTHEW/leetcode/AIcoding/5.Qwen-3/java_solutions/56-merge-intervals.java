public class Solution {

import java.util.*;

public class Solution {
    public List<Interval> merge(List<Interval> intervals) {
        if (intervals == null || intervals.size() <= 1) {
            return intervals;
        }

        Collections.sort(intervals, (a, b) -> a.start - b.start);

        List<Interval> merged = new ArrayList<>();
        merged.add(intervals.get(0));

        for (int i = 1; i < intervals.size(); i++) {
            Interval last = merged.get(merged.size() - 1);
            Interval current = intervals.get(i);

            if (current.start <= last.end) {
                last.end = Math.max(last.end, current.end);
            } else {
                merged.add(current);
            }
        }

        return merged;
    }
}
}