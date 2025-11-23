#include <stdio.h>
#include <stdlib.h>

int canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
    if (targetCapacity == 0) return 1;
    if (jug1Capacity + jug2Capacity < targetCapacity) return 0;
    if (jug1Capacity == targetCapacity || jug2Capacity == targetCapacity) return 1;

    int gcd = 0;
    int a = jug1Capacity;
    int b = jug2Capacity;

    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }

    gcd = a;

    return (targetCapacity % gcd == 0);
}