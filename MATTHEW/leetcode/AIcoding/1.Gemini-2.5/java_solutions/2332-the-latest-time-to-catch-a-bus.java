import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int latestTimeCatchTheBus(int[] buses, int[] passengers, int capacity) {
        Arrays.sort(buses);
        Arrays.sort(passengers);

        Set<Integer> passengerArrivalTimes = new HashSet<>();
        for (int p : passengers) {
            passengerArrivalTimes.add(p);
        }

        int pIdx = 0;
        int latestPossibleTime = -1;

        for (int i = 0; i < buses.length; i++) {
            int currentBusDepartureTime = buses[i];
            int passengersOnThisBus = 0;

            while (pIdx < passengers.length && passengers[pIdx] <= currentBusDepartureTime && passengersOnThisBus < capacity) {
                pIdx++;
                passengersOnThisBus++;
            }

            if (i == buses.length - 1) {
                if (passengersOnThisBus < capacity) {
                    latestPossibleTime = currentBusDepartureTime;
                    while (passengerArrivalTimes.contains(latestPossibleTime)) {
                        latestPossibleTime--;
                    }
                } else {
                    latestPossibleTime = passengers[pIdx - 1] - 1;
                    while (passengerArrivalTimes.contains(latestPossibleTime)) {
                        latestPossibleTime--;
                    }
                }
            }
        }
        return latestPossibleTime;
    }
}