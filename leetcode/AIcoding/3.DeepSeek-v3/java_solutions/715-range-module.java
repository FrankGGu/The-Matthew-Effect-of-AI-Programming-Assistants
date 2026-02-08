class RangeModule {
    TreeMap<Integer, Integer> intervals;

    public RangeModule() {
        intervals = new TreeMap<>();
    }

    public void addRange(int left, int right) {
        Integer start = intervals.floorKey(left);
        Integer end = intervals.floorKey(right);

        if (start != null && intervals.get(start) >= left) {
            left = start;
        }
        if (end != null && intervals.get(end) > right) {
            right = intervals.get(end);
        }

        intervals.subMap(left, true, right, true).clear();
        intervals.put(left, right);
    }

    public boolean queryRange(int left, int right) {
        Integer start = intervals.floorKey(left);
        if (start != null && intervals.get(start) >= right) {
            return true;
        }
        return false;
    }

    public void removeRange(int left, int right) {
        Integer start = intervals.floorKey(left);
        Integer end = intervals.floorKey(right);

        if (start != null && intervals.get(start) > left) {
            intervals.put(start, left);
        }
        if (end != null && intervals.get(end) > right) {
            intervals.put(right, intervals.get(end));
        }

        intervals.subMap(left, true, right, false).clear();
    }
}