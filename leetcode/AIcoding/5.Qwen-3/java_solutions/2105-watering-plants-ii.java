public class Solution {

import java.util.*;

public class Solution {
    public int wateringPlants(int[] plants, int capacity) {
        int steps = 0;
        int currentCapacity = capacity;

        for (int i = 0; i < plants.length; i++) {
            if (currentCapacity < plants[i]) {
                steps += 2 * i;
                currentCapacity = capacity;
            }
            steps++;
            currentCapacity -= plants[i];
        }

        return steps;
    }
}
}