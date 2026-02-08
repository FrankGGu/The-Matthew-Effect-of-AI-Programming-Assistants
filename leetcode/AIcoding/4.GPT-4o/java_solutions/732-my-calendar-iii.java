import java.util.TreeMap;

class MyCalendarThree {
    private TreeMap<Integer, Integer> timeline;

    public MyCalendarThree() {
        timeline = new TreeMap<>();
    }

    public int book(int start, int end) {
        timeline.put(start, timeline.getOrDefault(start, 0) + 1);
        timeline.put(end, timeline.getOrDefault(end, 0) - 1);
        int active = 0, maxActive = 0;
        for (int count : timeline.values()) {
            active += count;
            maxActive = Math.max(maxActive, active);
        }
        return maxActive;
    }
}