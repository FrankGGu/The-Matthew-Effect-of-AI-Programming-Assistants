public class Solution {
    public int eliminationGame(int n) {
        int step = 1;
        int head = 1;
        int remaining = n;
        boolean leftToRight = true;

        while (remaining > 1) {
            if (leftToRight) {
                head += step;
            } else {
                if (remaining % 2 != 0) {
                    head += step;
                }
            }
            remaining /= 2;
            step *= 2;
            leftToRight = !leftToRight;
        }

        return head;
    }
}