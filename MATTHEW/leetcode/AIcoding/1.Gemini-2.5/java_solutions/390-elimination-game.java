class Solution {
    public int lastRemaining(int n) {
        int head = 1;
        int step = 1;
        int remaining = n;
        boolean fromLeft = true;

        while (remaining > 1) {
            if (fromLeft) {
                head = head + step;
            } else { // fromRight
                if (remaining % 2 == 1) {
                    head = head + step;
                }
            }

            step = step * 2;
            remaining = remaining / 2;
            fromLeft = !fromLeft;
        }

        return head;
    }
}