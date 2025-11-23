class Solution {
public:
    int passThePillow(int n, int time) {
        int cycleLength = 2 * (n - 1);
        int effectiveTime = time % cycleLength;

        if (effectiveTime < n - 1) {
            return 1 + effectiveTime;
        } else {
            return n - (effectiveTime - (n - 1));
        }
    }
};