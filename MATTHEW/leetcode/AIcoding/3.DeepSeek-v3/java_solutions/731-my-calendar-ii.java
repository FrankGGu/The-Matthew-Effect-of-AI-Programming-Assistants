class MyCalendarTwo {
    private List<int[]> calendar;
    private List<int[]> overlaps;

    public MyCalendarTwo() {
        calendar = new ArrayList<>();
        overlaps = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] interval : overlaps) {
            if (interval[0] < end && start < interval[1]) {
                return false;
            }
        }
        for (int[] interval : calendar) {
            if (interval[0] < end && start < interval[1]) {
                overlaps.add(new int[]{Math.max(start, interval[0]), Math.min(end, interval[1])});
            }
        }
        calendar.add(new int[]{start, end});
        return true;
    }
}