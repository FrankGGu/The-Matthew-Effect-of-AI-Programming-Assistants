import java.util.Arrays;

public class Solution {
    public double averageWaitingTime(int[][] customers) {
        Arrays.sort(customers, (a, b) -> Integer.compare(a[0], b[0]));
        double totalWaitingTime = 0;
        int currentTime = 0;

        for (int[] customer : customers) {
            currentTime = Math.max(currentTime, customer[0]) + customer[1];
            totalWaitingTime += currentTime - customer[0];
        }

        return totalWaitingTime / customers.length;
    }
}