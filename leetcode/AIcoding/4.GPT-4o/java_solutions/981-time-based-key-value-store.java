import java.util.*;

class TimeMap {
    private Map<String, List<Pair>> map;

    public TimeMap() {
        map = new HashMap<>();
    }

    public void set(String key, String value, int timestamp) {
        map.putIfAbsent(key, new ArrayList<>());
        map.get(key).add(new Pair(value, timestamp));
    }

    public String get(String key, int timestamp) {
        if (!map.containsKey(key)) {
            return "";
        }
        List<Pair> values = map.get(key);
        int left = 0, right = values.size() - 1, bestIndex = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (values.get(mid).timestamp <= timestamp) {
                bestIndex = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return bestIndex == -1 ? "" : values.get(bestIndex).value;
    }

    private class Pair {
        String value;
        int timestamp;

        Pair(String value, int timestamp) {
            this.value = value;
            this.timestamp = timestamp;
        }
    }
}