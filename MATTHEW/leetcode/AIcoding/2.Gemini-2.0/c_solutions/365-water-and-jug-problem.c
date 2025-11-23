#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
    if (targetCapacity > jug1Capacity + jug2Capacity) {
        return false;
    }
    if (targetCapacity == 0) {
        return true;
    }
    if (jug1Capacity == 0 && jug2Capacity == 0) {
        return targetCapacity == 0;
    }
    return targetCapacity % gcd(jug1Capacity, jug2Capacity) == 0;
}