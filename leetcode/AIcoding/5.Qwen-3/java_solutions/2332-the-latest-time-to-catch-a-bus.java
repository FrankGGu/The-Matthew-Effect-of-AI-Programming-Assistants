public class Solution {

import java.util.*;

public class Solution {
    public int latestTimeCatchACab(int[] buses, int[] passengers, int capacity) {
        Arrays.sort(buses);
        Arrays.sort(passengers);

        int i = 0; // pointer for passengers
        int j = 0; // pointer for buses

        while (j < buses.length) {
            int busTime = buses[j];
            int count = 0;

            while (i < passengers.length && passengers[i] <= busTime && count < capacity) {
                if (passengers[i] < busTime) {
                    i++;
                } else {
                    break;
                }
                count++;
            }

            if (count < capacity) {
                // The bus is not full, so we can take the bus at busTime
                return busTime;
            }

            j++;
        }

        // If all buses are full, check the last passenger's time
        int lastPassenger = passengers[passengers.length - 1];
        return lastPassenger - 1;
    }
}
}