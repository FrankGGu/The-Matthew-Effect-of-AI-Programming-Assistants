public class Solution {

import java.util.*;

public class Solution {
    public int mergeIntervals(List<List<Integer>> intervals) {
        if (intervals == null || intervals.size() == 0) return 0;

        intervals.sort((a, b) -> a.get(0) - b.get(0));

        int count = 1;
        int end = intervals.get(0).get(1);

        for (int i = 1; i < intervals.size(); i++) {
            int start = intervals.get(i).get(0);
            if (start > end) {
                count++;
                end = intervals.get(i).get(1);
            } else {
                end = Math.min(end, intervals.get(i).get(1));
            }
        }

        return count;
    }
}
}