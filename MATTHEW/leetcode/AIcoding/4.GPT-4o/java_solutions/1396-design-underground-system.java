import java.util.HashMap;
import java.util.Map;

class UndergroundSystem {
    private class Trip {
        String startStation;
        int startTime;

        Trip(String startStation, int startTime) {
            this.startStation = startStation;
            this.startTime = startTime;
        }
    }

    private Map<Integer, Trip> checkInMap;
    private Map<String, Pair> travelMap;

    private class Pair {
        double totalTime;
        int trips;

        Pair(double totalTime, int trips) {
            this.totalTime = totalTime;
            this.trips = trips;
        }
    }

    public UndergroundSystem() {
        checkInMap = new HashMap<>();
        travelMap = new HashMap<>();
    }

    public void checkIn(int id, String stationName, int t) {
        checkInMap.put(id, new Trip(stationName, t));
    }

    public void checkOut(int id, String stationName, int t) {
        Trip trip = checkInMap.remove(id);
        String route = trip.startStation + "-" + stationName;
        double travelTime = t - trip.startTime;

        travelMap.putIfAbsent(route, new Pair(0, 0));
        Pair p = travelMap.get(route);
        p.totalTime += travelTime;
        p.trips++;
    }

    public double getAverageTime(String startStation, String endStation) {
        String route = startStation + "-" + endStation;
        Pair p = travelMap.get(route);
        return p.totalTime / p.trips;
    }
}