class Solution {
    public boolean canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
        if (targetCapacity == 0) {
            return true;
        }
        if (targetCapacity > jug1Capacity + jug2Capacity) {
            return false;
        }

        int commonDivisor = gcd(jug1Capacity, jug2Capacity);
        return targetCapacity % commonDivisor == 0;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}