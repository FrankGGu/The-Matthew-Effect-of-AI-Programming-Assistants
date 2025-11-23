import java.util.TreeMap;

class MyCalendarThree {

    TreeMap<Integer, Integer> timeline;

    public MyCalendarThree() {
        timeline = new TreeMap<>();
    }

    public int book(int start, int end) {
        timeline.put(start, timeline.getOrDefault(start, 0) + 1);
        timeline.put(end, timeline.getOrDefault(end, 0) - 1);

        int ongoing = 0;
        int max = 0;
        for (int change : timeline.values()) {
            ongoing += change;
            max = Math.max(max, ongoing);
        }
        return max;
    }
}