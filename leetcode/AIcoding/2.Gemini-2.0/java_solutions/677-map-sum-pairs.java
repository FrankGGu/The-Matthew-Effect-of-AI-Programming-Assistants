import java.util.HashMap;
import java.util.Map;

class MapSum {

    private Map<String, Integer> map;
    private Map<String, Integer> prefixMap;

    public MapSum() {
        map = new HashMap<>();
        prefixMap = new HashMap<>();
    }

    public void insert(String key, int val) {
        int delta = val - map.getOrDefault(key, 0);
        map.put(key, val);

        for (int i = 1; i <= key.length(); i++) {
            String prefix = key.substring(0, i);
            prefixMap.put(prefix, prefixMap.getOrDefault(prefix, 0) + delta);
        }
    }

    public int sum(String prefix) {
        return prefixMap.getOrDefault(prefix, 0);
    }
}