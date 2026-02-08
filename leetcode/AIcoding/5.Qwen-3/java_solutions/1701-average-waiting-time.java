public class Solution {

import java.util.List;

public class Solution {
    public double averageWaitingTime(List<int[]> customers) {
        double totalWait = 0;
        int currentTime = 0;

        for (int[] customer : customers) {
            int arrival = customer[0];
            int cooking = customer[1];

            if (currentTime < arrival) {
                currentTime = arrival;
            }

            currentTime += cooking;
            totalWait += currentTime - arrival;
        }

        return totalWait / customers.size();
    }
}
}