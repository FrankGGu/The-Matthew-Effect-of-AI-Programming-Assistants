#include <limits.h>

int maximumEnergyBoost(int* drinks, int drinksSize) {
    int max1 = INT_MIN;
    int max2 = INT_MIN;

    for (int i = 0; i < drinksSize; i++) {
        if (drinks[i] > max1) {
            max2 = max1;
            max1 = drinks[i];
        } else if (drinks[i] > max2) {
            max2 = drinks[i];
        }
    }

    return max1 + max2;
}