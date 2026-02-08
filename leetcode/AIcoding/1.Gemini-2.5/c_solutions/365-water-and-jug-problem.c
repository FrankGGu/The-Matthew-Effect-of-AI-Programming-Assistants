int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
    if (targetCapacity == 0) {
        return true;
    }
    if (targetCapacity > jug1Capacity + jug2Capacity) {
        return false;
    }

    return targetCapacity % gcd(jug1Capacity, jug2Capacity) == 0;
}