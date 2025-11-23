import java.util.HashMap;

class MapSum {
    private HashMap<String, Integer> map;
    private HashMap<String, Integer> sumMap;

    public MapSum() {
        map = new HashMap<>();
        sumMap = new HashMap<>();
    }

    public void insert(String key, int val) {
        int delta = val - map.getOrDefault(key, 0);
        map.put(key, val);
        for (String k : map.keySet()) {
            if (k.startsWith(key)) {
                sumMap.put(k, sumMap.getOrDefault(k, 0) + delta);
            }
        }
    }

    public int sum(String prefix) {
        return sumMap.getOrDefault(prefix, 0);
    }
}