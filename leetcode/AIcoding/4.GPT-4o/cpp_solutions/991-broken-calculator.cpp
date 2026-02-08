class Solution {
public:
    int brokenCalc(int X, int Y) {
        int steps = 0;
        while (Y > X) {
            if (Y % 2 == 0) {
                Y /= 2;
            } else {
                Y++;
            }
            steps++;
        }
        return steps + (X - Y);
    }
};