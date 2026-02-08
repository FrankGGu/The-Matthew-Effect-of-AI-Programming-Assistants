import java.util.Arrays;

public class Solution {
    public String latestTimeToCatchBus(int[] buses, int[] passengers, int capacity) {
        Arrays.sort(buses);
        Arrays.sort(passengers);
        int n = buses.length, m = passengers.length;
        int busIndex = 0, passengerIndex = 0;
        int lastBusTime = -1;

        while (busIndex < n) {
            int currentBus = buses[busIndex];
            int count = 0;

            while (passengerIndex < m && passengers[passengerIndex] <= currentBus && count < capacity) {
                count++;
                passengerIndex++;
            }
            lastBusTime = currentBus;
            busIndex++;
        }

        if (passengerIndex == 0 || buses[n - 1] < passengers[passengerIndex - 1]) {
            return String.format("%02d:%02d", lastBusTime / 60, lastBusTime % 60);
        }

        if (passengerIndex > 0 && passengers[passengerIndex - 1] == lastBusTime) {
            passengerIndex--;
        }

        int latestTime = passengerIndex == 0 ? lastBusTime : passengers[passengerIndex - 1] - 1;
        while (latestTime % 60 == 59) {
            latestTime--;
        }

        return String.format("%02d:%02d", latestTime / 60, latestTime % 60);
    }
}