import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class SummaryRanges {
    private TreeMap<Integer, Integer> intervals;

    public SummaryRanges() {
        intervals = new TreeMap<>();
    }

    public void addNum(int val) {
        Map.Entry<Integer, Integer> floorEntry = intervals.floorEntry(val);

        if (floorEntry != null && floorEntry.getValue() >= val) {
            return; // val is already covered by an existing interval
        }

        boolean mergeWithPrev = (floorEntry != null && floorEntry.getValue() == val - 1);
        boolean mergeWithNext = intervals.containsKey(val + 1);

        if (mergeWithPrev && mergeWithNext) {
            int start = floorEntry.getKey();
            int end = intervals.get(val + 1);
            intervals.remove(start);
            intervals.remove(val + 1);
            intervals.put(start, end);
        } else if (mergeWithPrev) {
            int start = floorEntry.getKey();
            intervals.put(start, val);
        } else if (mergeWithNext) {
            int end = intervals.get(val + 1);
            intervals.remove(val + 1);
            intervals.put(val, end);
        } else {
            intervals.put(val, val);
        }
    }

    public int[][] getIntervals() {
        List<int[]> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : intervals.entrySet()) {
            result.add(new int[]{entry.getKey(), entry.getValue()});
        }
        return result.toArray(new int[0][]);
    }
}