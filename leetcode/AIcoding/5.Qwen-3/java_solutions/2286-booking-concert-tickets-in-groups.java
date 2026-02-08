public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> assignBuses(int[] tickets, int[] passengers, int capacity) {
        Arrays.sort(tickets);
        Arrays.sort(passengers);
        List<Integer> result = new ArrayList<>();
        int i = 0, j = 0;
        while (i < tickets.length) {
            int count = 0;
            while (j < passengers.length && passengers[j] <= tickets[i]) {
                j++;
            }
            while (i < tickets.length && count < capacity) {
                if (j < passengers.length && passengers[j] == tickets[i]) {
                    j++;
                } else {
                    result.add(tickets[i]);
                    count++;
                }
                i++;
            }
        }
        return result;
    }
}
}