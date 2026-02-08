class CountIntervals {
    TreeMap<Integer, Integer> intervals;
    int count;

    public CountIntervals() {
        intervals = new TreeMap<>();
        count = 0;
    }

    public void add(int left, int right) {
        Integer start = intervals.floorKey(left);
        if (start == null) {
            start = intervals.higherKey(left);
        }
        while (start != null && start <= right) {
            int end = intervals.get(start);
            if (end >= left) {
                left = Math.min(left, start);
                right = Math.max(right, end);
                count -= (end - start + 1);
                intervals.remove(start);
            }
            start = intervals.higherKey(start);
        }
        intervals.put(left, right);
        count += (right - left + 1);
    }

    public int count() {
        return count;
    }
}