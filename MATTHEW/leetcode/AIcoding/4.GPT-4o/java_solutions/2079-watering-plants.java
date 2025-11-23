class Solution {
    public int wateringPlants(int[] plants, int capacity) {
        int steps = 0, currentWater = capacity;
        for (int i = 0; i < plants.length; i++) {
            if (currentWater < plants[i]) {
                steps += i * 2; // go back to the river
                currentWater = capacity; // refill
            }
            currentWater -= plants[i];
            steps++; // water the plant
        }
        return steps;
    }
}