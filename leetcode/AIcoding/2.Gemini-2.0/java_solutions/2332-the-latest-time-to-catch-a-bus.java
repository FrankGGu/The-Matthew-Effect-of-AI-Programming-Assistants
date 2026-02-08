import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int latestTimeCatchTheBus(int[] buses, int[] passengers, int capacity) {
        Arrays.sort(buses);
        Arrays.sort(passengers);
        Set<Integer> passengerSet = new HashSet<>();
        for (int passenger : passengers) {
            passengerSet.add(passenger);
        }

        int passengerIndex = 0;
        int lastPossibleTime = 0;

        for (int bus : buses) {
            int currentCapacity = 0;
            while (passengerIndex < passengers.length && passengers[passengerIndex] <= bus && currentCapacity < capacity) {
                passengerIndex++;
                currentCapacity++;
            }

            if (currentCapacity < capacity) {
                lastPossibleTime = bus;
            } else {
                lastPossibleTime = passengers[passengerIndex - 1] - 1;
            }

            while (passengerSet.contains(lastPossibleTime) && lastPossibleTime > 0) {
                lastPossibleTime--;
            }
        }

        return lastPossibleTime;
    }
}