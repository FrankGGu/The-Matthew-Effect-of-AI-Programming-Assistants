import java.util.TreeMap;

class CountIntervals {

    private TreeMap<Integer, Integer> intervals;
    private int count;

    public CountIntervals() {
        intervals = new TreeMap<>();
        count = 0;
    }

    public void add(int left, int right) {
        Integer start = intervals.floorKey(right);
        while (start != null && intervals.get(start) >= left) {
            left = Math.min(left, start);
            right = Math.max(right, intervals.get(start));
            count -= (intervals.get(start) - start + 1);
            intervals.remove(start);
            start = intervals.floorKey(right);
        }
        intervals.put(left, right);
        count += (right - left + 1);
    }

    public int count() {
        return count;
    }
}