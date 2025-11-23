import java.util.HashMap;
import java.util.Map;

class UndergroundSystem {

    private Map<Integer, Pair> checkInMap;
    private Map<String, PairDouble> routeMap;

    public UndergroundSystem() {
        checkInMap = new HashMap<>();
        routeMap = new HashMap<>();
    }

    public void checkIn(int id, String stationName, int t) {
        checkInMap.put(id, new Pair(stationName, t));
    }

    public void checkOut(int id, String stationName, int t) {
        Pair checkInInfo = checkInMap.get(id);
        checkInMap.remove(id);
        String startStation = checkInInfo.stationName;
        int startTime = checkInInfo.time;
        String route = startStation + "," + stationName;
        int travelTime = t - startTime;

        if (routeMap.containsKey(route)) {
            PairDouble routeInfo = routeMap.get(route);
            routeMap.put(route, new PairDouble(routeInfo.sum + travelTime, routeInfo.count + 1));
        } else {
            routeMap.put(route, new PairDouble(travelTime, 1));
        }
    }

    public double getAverageTime(String startStation, String endStation) {
        String route = startStation + "," + endStation;
        PairDouble routeInfo = routeMap.get(route);
        return (double) routeInfo.sum / routeInfo.count;
    }

    private static class Pair {
        String stationName;
        int time;

        public Pair(String stationName, int time) {
            this.stationName = stationName;
            this.time = time;
        }
    }

    private static class PairDouble {
        double sum;
        int count;

        public PairDouble(double sum, int count) {
            this.sum = sum;
            this.count = count;
        }
    }
}