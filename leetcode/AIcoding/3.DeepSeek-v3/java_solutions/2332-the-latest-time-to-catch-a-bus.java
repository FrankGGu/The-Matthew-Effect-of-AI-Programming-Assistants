class Solution {
    public int latestTimeCatchTheBus(int[] buses, int[] passengers, int capacity) {
        Arrays.sort(buses);
        Arrays.sort(passengers);
        int i = 0, j = 0;
        int lastPassenger = -1;
        int result = -1;

        while (i < buses.length && j < passengers.length) {
            int count = 0;
            while (j < passengers.length && passengers[j] <= buses[i] && count < capacity) {
                if (j == 0 || passengers[j] - 1 != passengers[j - 1]) {
                    result = passengers[j] - 1;
                }
                lastPassenger = passengers[j];
                j++;
                count++;
            }
            if (count < capacity && (j == 0 || passengers[j - 1] != buses[i])) {
                result = buses[i];
            }
            i++;
        }

        if (i < buses.length) {
            result = buses[buses.length - 1];
        }

        while (result > 0 && Arrays.binarySearch(passengers, result) >= 0) {
            result--;
        }

        return result;
    }
}