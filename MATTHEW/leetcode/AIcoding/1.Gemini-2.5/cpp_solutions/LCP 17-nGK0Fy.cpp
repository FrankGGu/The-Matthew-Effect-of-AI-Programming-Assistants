class Solution {
public:
    int robot(int n) {
        int steps = 0;
        while (n > 0) {
            if (n % 2 == 1) {
                n = (n - 1) / 2;
            } else {
                n = n / 2;
            }
            steps++;
        }
        return steps;
    }
};