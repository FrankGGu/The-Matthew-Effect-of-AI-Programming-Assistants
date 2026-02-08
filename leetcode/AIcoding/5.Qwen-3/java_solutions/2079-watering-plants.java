public class Solution {

import java.util.*;

public class Solution {
    public int wateringPlants(int[] plants, int capacity) {
        int currentCapacity = capacity;
        int steps = 0;
        for (int i = 0; i < plants.length; i++) {
            if (currentCapacity < plants[i]) {
                currentCapacity = capacity;
                steps += i * 2;
            }
            currentCapacity -= plants[i];
            steps++;
        }
        return steps;
    }
}
}