import java.util.TreeMap;

class RangeModule {

    private TreeMap<Integer, Integer> ranges;

    public RangeModule() {
        ranges = new TreeMap<>();
    }

    public void addRange(int left, int right) {
        Integer start = ranges.floorKey(left);
        if (start != null && ranges.get(start) >= left) {
            left = start;
            right = Math.max(right, ranges.get(start));
            ranges.remove(start);
        }

        Integer end = ranges.floorKey(right);
        while (end != null && ranges.get(end) > right) {
            right = Math.max(right, ranges.get(end));
            ranges.remove(end);
            end = ranges.floorKey(right);
        }

        ranges.put(left, right);
    }

    public boolean queryRange(int left, int right) {
        Integer start = ranges.floorKey(left);
        return start != null && ranges.get(start) >= right;
    }

    public void removeRange(int left, int right) {
        Integer start = ranges.floorKey(left);
        if (start != null && ranges.get(start) > left) {
            int end = ranges.get(start);
            ranges.remove(start);
            if (start < left) {
                ranges.put(start, left);
            }
            if (right < end) {
                ranges.put(right, end);
            }
        }

        Integer end = ranges.floorKey(right);
        while (end != null && ranges.get(end) > right) {
            int e = ranges.get(end);
            ranges.remove(end);
            if (right < e) {
                ranges.put(right, e);
            }
            end = ranges.floorKey(right);
        }
    }
}