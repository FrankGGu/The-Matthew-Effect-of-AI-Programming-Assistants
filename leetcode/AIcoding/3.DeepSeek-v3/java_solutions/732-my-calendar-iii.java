class MyCalendarThree {
    private TreeMap<Integer, Integer> timeline;

    public MyCalendarThree() {
        timeline = new TreeMap<>();
    }

    public int book(int start, int end) {
        timeline.put(start, timeline.getOrDefault(start, 0) + 1);
        timeline.put(end, timeline.getOrDefault(end, 0) - 1);

        int active = 0, max = 0;
        for (int v : timeline.values()) {
            active += v;
            if (active > max) {
                max = active;
            }
        }
        return max;
    }
}