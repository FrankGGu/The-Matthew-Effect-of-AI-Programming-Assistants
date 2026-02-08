class Solution {
    public int wateringPlants(int[] plants, int capacity) {
        int steps = 0;
        int currentCapacity = capacity;
        for (int i = 0; i < plants.length; i++) {
            if (currentCapacity >= plants[i]) {
                steps++;
                currentCapacity -= plants[i];
            } else {
                steps += (i * 2);
                currentCapacity = capacity - plants[i];
                steps++;
            }
        }
        return steps;
    }
}