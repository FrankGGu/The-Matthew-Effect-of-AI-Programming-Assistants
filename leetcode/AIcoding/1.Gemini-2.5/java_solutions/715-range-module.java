import java.util.TreeMap;
import java.util.Map;
import java.util.Iterator;

class RangeModule {
    private TreeMap<Integer, Integer> map;

    public RangeModule() {
        map = new TreeMap<>();
    }

    public void addRange(int left, int right) {
        if (left >= right) return;

        Map.Entry<Integer, Integer> prev = map.floorEntry(left);
        if (prev != null && prev.getValue() >= left) {
            left = prev.getKey();
            right = Math.max(right, prev.getValue());
            map.remove(prev.getKey());
        }

        Iterator<Map.Entry<Integer, Integer>> it = map.tailMap(left).entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Integer, Integer> entry = it.next();
            if (entry.getKey() <= right) {
                right = Math.max(right, entry.getValue());
                it.remove();
            } else {
                break;
            }
        }
        map.put(left, right);
    }

    public boolean queryRange(int left, int right) {
        if (left >= right) return true;

        Map.Entry<Integer, Integer> entry = map.floorEntry(left);
        return entry != null && entry.getValue() >= right;
    }

    public void removeRange(int left, int right) {
        if (left >= right) return;

        Map.Entry<Integer, Integer> prev = map.floorEntry(left);
        if (prev != null && prev.getValue() > left) {
            if (prev.getValue() > right) {
                map.put(prev.getKey(), left);
                map.put(right, prev.getValue());
                return;
            }
            map.put(prev.getKey(), left);
        }

        Iterator<Map.Entry<Integer, Integer>> it = map.tailMap(left).entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Integer, Integer> entry = it.next();
            if (entry.getKey() >= right) {
                break;
            }
            if (entry.getValue() > right) {
                map.put(right, entry.getValue());
                it.remove();
                break;
            }
            it.remove();
        }
    }
}