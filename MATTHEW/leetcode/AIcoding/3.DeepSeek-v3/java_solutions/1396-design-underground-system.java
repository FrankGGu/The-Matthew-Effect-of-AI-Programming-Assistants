class UndergroundSystem {
    private Map<Integer, Pair<String, Integer>> checkIns;
    private Map<String, Pair<Double, Integer>> travelTimes;

    public UndergroundSystem() {
        checkIns = new HashMap<>();
        travelTimes = new HashMap<>();
    }

    public void checkIn(int id, String stationName, int t) {
        checkIns.put(id, new Pair<>(stationName, t));
    }

    public void checkOut(int id, String stationName, int t) {
        Pair<String, Integer> checkIn = checkIns.get(id);
        String startStation = checkIn.getKey();
        int startTime = checkIn.getValue();
        String route = startStation + "," + stationName;
        int travelTime = t - startTime;

        Pair<Double, Integer> existing = travelTimes.getOrDefault(route, new Pair<>(0.0, 0));
        travelTimes.put(route, new Pair<>(existing.getKey() + travelTime, existing.getValue() + 1));
    }

    public double getAverageTime(String startStation, String endStation) {
        String route = startStation + "," + endStation;
        Pair<Double, Integer> stats = travelTimes.get(route);
        return stats.getKey() / stats.getValue();
    }
}

class Pair<K, V> {
    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K getKey() {
        return key;
    }

    public V getValue() {
        return value;
    }
}