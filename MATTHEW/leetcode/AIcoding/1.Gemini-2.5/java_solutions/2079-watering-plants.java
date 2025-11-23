class Solution {
    public int wateringPlants(int[] plants, int capacity) {
        int steps = 0;
        int currentWater = capacity;

        for (int i = 0; i < plants.length; i++) {
            // Check if current water is sufficient for the current plant
            if (currentWater < plants[i]) {
                // Not enough water, need to go back to the river and refill.
                // The decision to refill is made before walking to plant 'i'.
                // So, if a refill is needed for plant 'i', we are currently at plant 'i-1'
                // (or at the river for i=0).

                // Steps to go back to the river from the previous plant (position i-1).
                // The river is at position -1.
                // Distance = (i-1) - (-1) = i.
                // If i=0, this is 0 steps, as we are effectively at the river.
                steps += i; 

                // Steps to walk from the river (position -1) to the current plant (position i).
                // Distance = i - (-1) = i + 1.
                steps += (i + 1);

                // Refill the watering can to full capacity
                currentWater = capacity;
            } else {
                // Enough water, just walk to the current plant.
                // This step is either from the river to plant 0 (1 step)
                // or from plant i-1 to plant i (1 step).
                steps += 1;
            }

            // Water the plant
            currentWater -= plants[i];
        }

        return steps;
    }
}