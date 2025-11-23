class Solution {
public:
    int countEven(int n) {
        int count = 0;
        for (int i = 100; i < 1000; ++i) {
            if (i % 2 == 0) {
                count++;
            }
        }
        return count;
    }
};