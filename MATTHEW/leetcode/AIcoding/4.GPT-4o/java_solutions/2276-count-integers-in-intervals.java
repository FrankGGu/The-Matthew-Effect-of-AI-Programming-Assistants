class CountIntervals {
    private TreeMap<Integer, Integer> intervals;

    public CountIntervals() {
        intervals = new TreeMap<>();
    }

    public void add(int left, int right) {
        Map.Entry<Integer, Integer> floorEntry = intervals.floorEntry(right);
        if (floorEntry != null && floorEntry.getValue() >= left) {
            left = Math.min(left, floorEntry.getKey());
            right = Math.max(right, floorEntry.getValue());
            intervals.remove(floorEntry.getKey());
        }
        intervals.put(left, right);
    }

    public int count() {
        int count = 0;
        for (Map.Entry<Integer, Integer> entry : intervals.entrySet()) {
            count += entry.getValue() - entry.getKey() + 1;
        }
        return count;
    }
}