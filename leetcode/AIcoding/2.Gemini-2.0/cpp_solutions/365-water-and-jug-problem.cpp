class Solution {
public:
    bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
        if (targetCapacity > jug1Capacity + jug2Capacity) return false;
        if (targetCapacity == 0) return true;
        if (jug1Capacity == 0 && jug2Capacity == 0) return false;

        int gcdValue = gcd(jug1Capacity, jug2Capacity);
        if (gcdValue == 0) return jug1Capacity + jug2Capacity >= targetCapacity;

        return targetCapacity % gcdValue == 0;
    }

private:
    int gcd(int a, int b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }
};