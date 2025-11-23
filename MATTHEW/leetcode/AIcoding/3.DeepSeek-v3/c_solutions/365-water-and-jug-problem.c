bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
    if (targetCapacity > jug1Capacity + jug2Capacity) return false;
    if (targetCapacity == 0) return true;

    int gcd = 0;
    int a = jug1Capacity, b = jug2Capacity;
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    gcd = a;

    return targetCapacity % gcd == 0;
}