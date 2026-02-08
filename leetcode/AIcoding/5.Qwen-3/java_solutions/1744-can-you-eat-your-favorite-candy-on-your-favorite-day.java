public class Solution {

import java.util.*;

public class Solution {
    public boolean[] canEat(int[] candiesCount, int[][] queries) {
        boolean[] result = new boolean[queries.length];
        long[] prefixSum = new long[candiesCount.length + 1];

        for (int i = 0; i < candiesCount.length; i++) {
            prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
        }

        for (int i = 0; i < queries.length; i++) {
            int favoriteCandyType = queries[i][0];
            int favoriteDay = queries[i][1];
            int dailyCap = queries[i][2];

            long minEaten = favoriteDay + 1;
            long maxEaten = (long) (favoriteDay + 1) * dailyCap;

            long minPossible = prefixSum[favoriteCandyType];
            long maxPossible = prefixSum[favoriteCandyType + 1];

            if (maxEaten <= minPossible || minEaten > maxPossible) {
                result[i] = false;
            } else {
                result[i] = true;
            }
        }

        return result;
    }
}
}