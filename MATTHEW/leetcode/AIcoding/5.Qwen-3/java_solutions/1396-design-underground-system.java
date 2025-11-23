public class UndergroundSystem {
    private Map<String, Pair<String, Integer>> checkInMap;
    private Map<String, Pair<Integer, Integer>> averageMap;

    public UndergroundSystem() {
        checkInMap = new HashMap<>();
        averageMap = new HashMap<>();
    }

    public void checkIn(int id, String stationName, int t) {
        checkInMap.put(id, new Pair<>(stationName, t));
    }

    public void checkOut(int id, String stationName, int t) {
        Pair<String, Integer> checkIn = checkInMap.get(id);
        String startStation = checkIn.getKey();
        int startTime = checkIn.getValue();
        String route = startStation + "-" + stationName;
        int duration = t - startTime;
        if (averageMap.containsKey(route)) {
            Pair<Integer, Integer> avg = averageMap.get(route);
            int total = avg.getKey() + duration;
            int count = avg.getValue() + 1;
            averageMap.put(route, new Pair<>(total, count));
        } else {
            averageMap.put(route, new Pair<>(duration, 1));
        }
        checkInMap.remove(id);
    }

    public double getAverageTime(String startStation, String endStation) {
        String route = startStation + "-" + endStation;
        Pair<Integer, Integer> avg = averageMap.get(route);
        return (double) avg.getKey() / avg.getValue();
    }
}