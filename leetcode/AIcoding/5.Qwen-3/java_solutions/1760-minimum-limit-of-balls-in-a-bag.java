public class Solution {

import java.util.Arrays;

public class Solution {
    public int minimumLimitOfBallsInABag(int[] capacity, int maxOperations) {
        Arrays.sort(capacity);
        int n = capacity.length;
        int operations = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (capacity[i] <= maxOperations) {
                return capacity[i];
            }
            operations += capacity[i] - maxOperations;
            if (operations > maxOperations) {
                return capacity[i] - operations + maxOperations;
            }
        }
        return capacity[0];
    }
}
}