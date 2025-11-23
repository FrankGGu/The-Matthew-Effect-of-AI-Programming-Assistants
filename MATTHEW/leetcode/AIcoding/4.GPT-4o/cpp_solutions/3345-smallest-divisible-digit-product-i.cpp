class Solution {
public:
    int smallestDivisible(int n) {
        for (int i = 1; ; ++i) {
            if (i % n == 0) {
                return i;
            }
        }
    }
};