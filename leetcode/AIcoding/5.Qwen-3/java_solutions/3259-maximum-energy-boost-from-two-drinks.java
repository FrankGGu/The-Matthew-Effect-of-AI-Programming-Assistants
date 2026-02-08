public class Solution {

import java.util.*;

public class Solution {
    public int maxEnergyBoost(List<Integer> energyDrinkA, List<Integer> energyDrinkB) {
        int n = energyDrinkA.size();
        int[] dpA = new int[n];
        int[] dpB = new int[n];

        dpA[0] = energyDrinkA.get(0);
        dpB[0] = energyDrinkB.get(0);

        for (int i = 1; i < n; i++) {
            dpA[i] = Math.max(dpA[i - 1], dpB[i - 1]) + energyDrinkA.get(i);
            dpB[i] = Math.max(dpA[i - 1], dpB[i - 1]) + energyDrinkB.get(i);
        }

        return Math.max(dpA[n - 1], dpB[n - 1]);
    }
}
}