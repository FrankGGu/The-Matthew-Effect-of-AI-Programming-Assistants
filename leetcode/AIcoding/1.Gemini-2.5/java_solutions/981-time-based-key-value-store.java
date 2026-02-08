import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class TimeMap {

    private Map<String, TreeMap<Integer, String>> store;

    public TimeMap() {
        store = new HashMap<>();
    }

    public void set(String key, String value, int timestamp) {
        store.computeIfAbsent(key, k -> new TreeMap<>()).put(timestamp, value);
    }

    public String get(String key, int timestamp) {
        TreeMap<Integer, String> keyTimestamps = store.get(key);
        if (keyTimestamps == null) {
            return "";
        }
        Map.Entry<Integer, String> entry = keyTimestamps.floorEntry(timestamp);
        if (entry == null) {
            return "";
        }
        return entry.getValue();
    }
}