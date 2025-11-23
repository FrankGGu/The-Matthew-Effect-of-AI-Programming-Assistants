class SummaryRanges {
    private TreeSet<int[]> intervals;

    public SummaryRanges() {
        intervals = new TreeSet<>((a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
    }

    public void addNum(int value) {
        int[] newInterval = new int[]{value, value};
        int[] floor = intervals.floor(newInterval);
        if (floor != null && floor[1] >= value) {
            return;
        }
        int[] higher = intervals.higher(newInterval);
        if (floor != null && floor[1] + 1 == value) {
            newInterval[0] = floor[0];
            intervals.remove(floor);
        }
        if (higher != null && higher[0] - 1 == value) {
            newInterval[1] = higher[1];
            intervals.remove(higher);
        }
        intervals.add(newInterval);
    }

    public int[][] getIntervals() {
        int[][] res = new int[intervals.size()][2];
        int i = 0;
        for (int[] interval : intervals) {
            res[i++] = interval;
        }
        return res;
    }
}