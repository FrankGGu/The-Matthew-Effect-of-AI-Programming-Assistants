#include <stdlib.h> // For labs
#include <limits.h> // For LONG_MAX
#include <stdbool.h> // For bool

void generateToppingSums(int* toppingCosts, int toppingCostsSize, int index, int currentSum, bool* possibleToppingSums) {
    // Base case: all toppings have been considered
    if (index == toppingCostsSize) {
        if (currentSum <= 200000) { // Ensure sum is within array bounds
            possibleToppingSums[currentSum] = true;
        }
        return;
    }

    // Option 1: Don't add the current topping
    generateToppingSums(toppingCosts, toppingCostsSize, index + 1, currentSum, possibleToppingSums);

    // Option 2: Add the current topping once
    generateToppingSums(toppingCosts, toppingCostsSize, index + 1, currentSum + toppingCosts[index], possibleToppingSums);

    // Option 3: Add the current topping twice
    generateToppingSums(toppingCosts, toppingCostsSize, index + 1, currentSum + 2 * toppingCosts[index], possibleToppingSums);
}

int closestCost(int* baseCosts, int baseCostsSize, int* toppingCosts, int toppingCostsSize, int target) {
    // The maximum possible sum of toppings is 10 toppings * 2 times * 10^4 per topping = 200,000.
    // We use a boolean array to mark all achievable topping sums.
    bool possibleToppingSums[200001] = {false}; // Initialize all to false

    // Generate all possible topping sums recursively
    generateToppingSums(toppingCosts, toppingCostsSize, 0, 0, possibleToppingSums);

    long minDiff = LONG_MAX; // Use long to handle large differences with target
    int closestCostVal = -1;

    // Iterate through each base cost
    for (int i = 0; i < baseCostsSize; i++) {
        int base = baseCosts[i];

        // Iterate through all possible topping sums
        for (int toppingSum = 0; toppingSum <= 200000; toppingSum++) {
            if (possibleToppingSums[toppingSum]) {
                long currentTotalCost = (long)base + toppingSum;
                long currentDiff = labs(currentTotalCost - target);

                if (currentDiff < minDiff) {
                    minDiff = currentDiff;
                    closestCostVal = (int)currentTotalCost;
                } else if (currentDiff == minDiff) {
                    // If differences are equal, choose the smaller cost
                    if (currentTotalCost < closestCostVal) {
                        closestCostVal = (int)currentTotalCost;
                    }
                }
            }
        }
    }

    return closestCostVal;
}