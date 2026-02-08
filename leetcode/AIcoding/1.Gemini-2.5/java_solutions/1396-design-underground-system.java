import java.util.HashMap;
import java.util.Objects;

class UndergroundSystem {

    private static class CheckInInfo {
        String stationName;
        int time;

        public CheckInInfo(String stationName, int time) {
            this.stationName = stationName;
            this.time = time;
        }
    }

    private static class TripStats {
        long totalTime;
        int count;

        public TripStats() {
            this.totalTime = 0;
            this.count = 0;
        }
    }

    private static class TripKey {
        String startStation;
        String endStation;

        public TripKey(String startStation, String endStation) {
            this.startStation = startStation;
            this.endStation = endStation;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            TripKey tripKey = (TripKey) o;
            return startStation.equals(tripKey.startStation) &&
                   endStation.equals(tripKey.endStation);
        }

        @Override
        public int hashCode() {
            return Objects.hash(startStation, endStation);
        }
    }

    private HashMap<Integer, CheckInInfo> customerCheckIns;
    private HashMap<TripKey, TripStats> stationPairStats;

    public UndergroundSystem() {
        customerCheckIns = new HashMap<>();
        stationPairStats = new HashMap<>();
    }

    public void checkIn(int id, String stationName, int t) {
        customerCheckIns.put(id, new CheckInInfo(stationName, t));
    }

    public void checkOut(int id, String stationName, int t) {
        CheckInInfo checkIn = customerCheckIns.remove(id);

        String startStation = checkIn.stationName;
        int checkInTime = checkIn.time;
        String endStation = stationName;

        long tripDuration = t - checkInTime;

        TripKey key = new TripKey(startStation, endStation);
        TripStats stats = stationPairStats.getOrDefault(key, new TripStats());

        stats.totalTime += tripDuration;
        stats.count++;

        stationPairStats.put(key, stats);
    }

    public double getAverageTime(String startStation, String endStation) {
        TripKey key = new TripKey(startStation, endStation);
        TripStats stats = stationPairStats.get(key);

        return (double) stats.totalTime / stats.count;
    }
}