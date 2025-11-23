bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
    if (targetCapacity > jug1Capacity + jug2Capacity) return false;
    if (targetCapacity == 0) return true;
    int gcd = __gcd(jug1Capacity, jug2Capacity);
    return targetCapacity % gcd == 0;
}