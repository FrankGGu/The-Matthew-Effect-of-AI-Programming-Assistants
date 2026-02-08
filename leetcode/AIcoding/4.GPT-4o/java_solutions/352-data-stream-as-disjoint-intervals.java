import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

class SummaryRanges {
    private final TreeSet<int[]> intervals;

    public SummaryRanges() {
        intervals = new TreeSet<>((a, b) -> a[0] - b[0]);
    }

    public void addNum(int value) {
        int[] newInterval = {value, value};
        int[] floor = intervals.floor(newInterval);
        int[] ceil = intervals.ceiling(newInterval);

        if (floor != null && floor[1] + 1 >= value) {
            newInterval[0] = floor[0];
            newInterval[1] = Math.max(floor[1], value);
            intervals.remove(floor);
        }
        if (ceil != null && ceil[0] <= value + 1) {
            newInterval[1] = Math.max(newInterval[1], ceil[1]);
            intervals.remove(ceil);
        }
        intervals.add(newInterval);
    }

    public List<List<Integer>> getIntervals() {
        List<List<Integer>> result = new ArrayList<>();
        for (int[] interval : intervals) {
            List<Integer> list = new ArrayList<>();
            list.add(interval[0]);
            list.add(interval[1]);
            result.add(list);
        }
        return result;
    }
}