class Solution {
public:
    int lastRemaining(int n) {
        int head = 1;
        int remaining = n;
        bool isLeftToRight = true;
        int step = 1;

        while (remaining > 1) {
            if (isLeftToRight || remaining % 2 == 1) {
                head += step;
            }
            step *= 2;
            remaining /= 2;
            isLeftToRight = !isLeftToRight;
        }
        return head;
    }
};