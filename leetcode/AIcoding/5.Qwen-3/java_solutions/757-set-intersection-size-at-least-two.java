public class Solution {

import java.util.*;

public class Solution {
    public int intersectionSizeOne(List<List<Integer>> intervals) {
        if (intervals == null || intervals.size() == 0) return 0;

        intervals.sort((a, b) -> a.get(1) - b.get(1));

        int res = 0;
        int last = -1;
        int secondLast = -1;

        for (List<Integer> interval : intervals) {
            int start = interval.get(0);
            int end = interval.get(1);

            if (start > secondLast) {
                res += 2;
                secondLast = end - 1;
                last = end;
            } else if (start > last) {
                res += 1;
                secondLast = last;
                last = end;
            }
        }

        return res;
    }
}
}