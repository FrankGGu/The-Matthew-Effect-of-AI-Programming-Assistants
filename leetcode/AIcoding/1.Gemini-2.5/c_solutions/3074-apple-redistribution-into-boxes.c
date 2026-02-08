#include <stdbool.h>

bool redistributeApples(int* apple, int appleSize, int* capacity, int capacitySize) {
    long long totalApples = 0;
    for (int i = 0; i < appleSize; i++) {
        totalApples += apple[i];
    }

    long long totalCapacity = 0;
    for (int i = 0; i < capacitySize; i++) {
        totalCapacity += capacity[i];
    }

    return totalApples <= totalCapacity;
}