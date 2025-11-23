public class Solution {

import java.util.*;

public class Solution {
    public int maximumPopulation(int[][] logs) {
        int[] delta = new int[101];
        for (int[] log : logs) {
            int birth = log[0];
            int death = log[1];
            delta[birth - 1950]++;
            delta[death - 1950]--;
        }

        int maxPopulation = 0;
        int currentPopulation = 0;
        int resultYear = 1950;

        for (int i = 0; i < 101; i++) {
            currentPopulation += delta[i];
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                resultYear = 1950 + i;
            }
        }

        return resultYear;
    }
}
}