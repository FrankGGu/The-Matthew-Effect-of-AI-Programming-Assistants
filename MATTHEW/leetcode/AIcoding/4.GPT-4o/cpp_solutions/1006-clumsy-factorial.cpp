class Solution {
public:
    int clumsy(int N) {
        if (N == 0) return 0;
        if (N == 1) return 1;
        if (N == 2) return 2;
        if (N == 3) return 6;

        int result = 0;
        int sign = 1;

        for (int i = N; i > 0; i -= 4) {
            result += sign * i * (i > 1 ? (i - 1) : 1) / (i > 2 ? (i - 2) : 1);
            sign = -sign;
        }

        return result;
    }
};