import java.util.Arrays;

class Solution {

    private int upperBound(int[] arr, int val) {
        int low = 0;
        int high = arr.length;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] <= val) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    private int lowerBound(int[] arr, int val) {
        int low = 0;
        int high = arr.length;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] < val) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    public int[] fullBloomFlowers(int[][] flowers, int[] people) {
        int n = flowers.length;
        int m = people.length;

        int[] startTimes = new int[n];
        int[] endTimes = new int[n];

        for (int i = 0; i < n; i++) {
            startTimes[i] = flowers[i][0];
            endTimes[i] = flowers[i][1];
        }

        Arrays.sort(startTimes);
        Arrays.sort(endTimes);

        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int personArrivalTime = people[i];

            int startedCount = upperBound(startTimes, personArrivalTime);
            int wiltedCount = lowerBound(endTimes, personArrivalTime);

            result[i] = startedCount - wiltedCount;
        }

        return result;
    }
}