import java.util.HashMap;
import java.util.TreeMap;

class TimeMap {

    private HashMap<String, TreeMap<Integer, String>> map;

    public TimeMap() {
        map = new HashMap<>();
    }

    public void set(String key, String value, int timestamp) {
        if (!map.containsKey(key)) {
            map.put(key, new TreeMap<>());
        }
        map.get(key).put(timestamp, value);
    }

    public String get(String key, int timestamp) {
        if (!map.containsKey(key)) {
            return "";
        }
        TreeMap<Integer, String> treeMap = map.get(key);
        Integer floorKey = treeMap.floorKey(timestamp);
        if (floorKey == null) {
            return "";
        }
        return treeMap.get(floorKey);
    }
}