import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

public class SummaryRanges {

    private TreeSet<Integer> set;

    public SummaryRanges() {
        set = new TreeSet<>();
    }

    public void addNum(int value) {
        set.add(value);
    }

    public int[][] getIntervals() {
        if (set.isEmpty()) {
            return new int[0][0];
        }

        List<int[]> intervals = new ArrayList<>();
        int start = -1;
        int end = -1;

        for (int num : set) {
            if (start == -1) {
                start = num;
                end = num;
            } else if (num == end + 1) {
                end = num;
            } else {
                intervals.add(new int[]{start, end});
                start = num;
                end = num;
            }
        }

        intervals.add(new int[]{start, end});
        return intervals.toArray(new int[intervals.size()][]);
    }
}