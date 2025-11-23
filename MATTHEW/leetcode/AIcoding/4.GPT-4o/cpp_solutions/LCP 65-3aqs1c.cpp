class Solution {
public:
    int comfortableNumbers(int L, int R) {
        int count = 0;
        for (int a = L; a <= R; ++a) {
            for (int b = L; b <= R; ++b) {
                if (abs(a - b) <= 2) {
                    int a_min = max(0, a - 10);
                    int a_max = min(100, a + 10);
                    int b_min = max(0, b - 10);
                    int b_max = min(100, b + 10);
                    if (b_min <= a && a <= b_max) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};