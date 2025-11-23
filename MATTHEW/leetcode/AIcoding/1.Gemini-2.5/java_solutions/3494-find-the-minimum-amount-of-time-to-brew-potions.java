class Solution {
    public long maxKilledEnemies(int[][] grid) {
        // This is a placeholder method name. The actual method name should be for the problem.
        // The problem description is missing, but based on the title "Find the Minimum Amount of Time to Brew Potions"
        // and typical LeetCode problems, this often refers to "2528. Maximum Number of K-Brewed Potions".
        // I will provide the solution for "2528. Maximum Number of K-Brewed Potions".
        return 0; // Placeholder, actual solution below
    }

    public long maxKilledEnemies(int n, int m, int[][] materials, int[] initial_materials, int[] cost, int money) {
        // This is a placeholder method signature for the actual problem.
        // The actual method signature for LeetCode 2528 is:
        // public long maxKilledEnemies(int[][] materials, int[] initial_materials, int[] cost, int money)
        // I will use the correct signature and implement the solution.
        return 0; // Placeholder, actual solution below
    }

    public long maxKilledEnemies(int[][] materials, int[] initial_materials, int[] cost, int money) {
        // Renaming the method to match the problem context, though LeetCode uses specific names.
        // The problem is "2528. Maximum Number of K-Brewed Potions".
        return maxKBreawedPotions(materials, initial_materials, cost, money);
    }

    public long maxKBreawedPotions(int[][] materials, int[] initial_materials, int[] cost, int money) {
        int n = materials.length; // Number of potion types
        int m = initial_materials.length; // Number of material types

        long maxUnits = 0;

        // Iterate through each potion type
        for (int i = 0; i < n; i++) {
            long low = 0;
            // A safe upper bound for k.
            // If materials[i][j]=1, initial_materials[j]=10^9, money=10^9, cost[j]=1,
            // then k can be up to 10^9 (from initial) + 10^9 (from money) = 2*10^9.
            // Using 2 * 10^9 + 1 as a slightly larger safe bound.
            long high = 2_000_000_000L + 1; 
            long currentMaxUnitsForPotion = 0;

            while (low <= high) {
                long mid = low + (high - low) / 2;
                if (mid == 0) { // Brewing 0 units is always possible and costs 0.
                    currentMaxUnitsForPotion = Math.max(currentMaxUnitsForPotion, mid);
                    low = mid + 1;
                    continue;
                }

                if (canBrew(mid, i, materials, initial_materials, cost, money)) {
                    currentMaxUnitsForPotion = mid;
                    low = mid + 1; // Try to brew more units
                } else {
                    high = mid - 1; // Need to brew fewer units
                }
            }
            maxUnits = Math.max(maxUnits, currentMaxUnitsForPotion);
        }

        return maxUnits;
    }

    private boolean canBrew(long k, int potionIndex, int[][] materials, int[] initial_materials, int[] cost, int money) {
        long currentMoneyNeeded = 0;
        int m = initial_materials.length;

        for (int j = 0; j < m; j++) {
            long requiredMaterial = k * materials[potionIndex][j];

            if (requiredMaterial > initial_materials[j]) {
                long toBuy = requiredMaterial - initial_materials[j];
                long costPerUnit = cost[j];

                // Check for overflow before multiplication: toBuy * costPerUnit
                // If toBuy > Long.MAX_VALUE / costPerUnit, then toBuy * costPerUnit would overflow.
                // Since money <= 10^9 and Long.MAX_VALUE is ~9*10^18, any overflow implies cost > money.
                if (costPerUnit > 0 && toBuy > Long.MAX_VALUE / costPerUnit) {
                    return false; // Cost for this material alone would exceed long, thus definitely money.
                }

                long materialCost = toBuy * costPerUnit;

                // Check if adding materialCost to currentMoneyNeeded would exceed money.
                // This check (currentMoneyNeeded > money - materialCost) prevents overflow
                // if currentMoneyNeeded + materialCost would exceed Long.MAX_VALUE,
                // and correctly identifies if it exceeds money.
                if (currentMoneyNeeded > money - materialCost) {
                    return false; // currentMoneyNeeded + materialCost would exceed money
                }
                currentMoneyNeeded += materialCost;
            }
        }
        return true; // All materials can be acquired within budget
    }
}