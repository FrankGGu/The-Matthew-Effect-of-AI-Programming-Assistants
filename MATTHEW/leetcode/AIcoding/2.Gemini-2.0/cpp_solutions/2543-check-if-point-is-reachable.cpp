class Solution {
public:
    bool gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a == 1;
    }

    bool isReachable(int targetX, int targetY) {
        return gcd(targetX, targetY);
    }
};