import java.util.*;

class RangeModule {
    private TreeMap<Integer, Integer> map;

    public RangeModule() {
        map = new TreeMap<>();
    }

    public void addRange(int left, int right) {
        Integer start = map.floorKey(left);
        Integer end = map.floorKey(right);

        if (start != null && map.get(start) >= left) {
            left = Math.min(left, start);
        } else {
            start = null;
        }

        if (end != null && map.get(end) > right) {
            right = Math.max(right, map.get(end));
            map.remove(end);
        }

        if (start != null) {
            map.remove(start);
        }

        map.put(left, right);
    }

    public boolean queryRange(int left, int right) {
        Map.Entry<Integer, Integer> entry = map.floorEntry(left);
        return entry != null && entry.getValue() >= right;
    }

    public void removeRange(int left, int right) {
        Integer start = map.floorKey(left);
        Integer end = map.floorKey(right);

        if (start != null && map.get(start) > left) {
            map.put(start, left);
        }

        if (end != null && map.get(end) > right) {
            map.put(right, map.get(end));
            map.remove(end);
        }

        if (start != null && map.get(start) >= right) {
            map.remove(start);
        }
    }
}