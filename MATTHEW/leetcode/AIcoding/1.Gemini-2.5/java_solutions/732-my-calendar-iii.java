import java.util.TreeMap;

class MyCalendarThree {
    private TreeMap<Integer, Integer> map;

    public MyCalendarThree() {
        map = new TreeMap<>();
    }

    public int book(int start, int end) {
        map.put(start, map.getOrDefault(start, 0) + 1);
        map.put(end, map.getOrDefault(end, 0) - 1);

        int currentOverlap = 0;
        int maxOverlap = 0;

        for (int delta : map.values()) {
            currentOverlap += delta;
            maxOverlap = Math.max(maxOverlap, currentOverlap);
        }

        return maxOverlap;
    }
}