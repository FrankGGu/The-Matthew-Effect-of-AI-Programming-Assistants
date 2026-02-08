int lastRemaining(int n) {
    int head = 1;
    int remaining = n;
    int step = 1;
    _Bool leftToRight = 1; // true for left-to-right, false for right-to-left

    while (remaining > 1) {
        if (leftToRight || remaining % 2 == 1) {
            head += step;
        }

        remaining /= 2;
        step *= 2;
        leftToRight = !leftToRight;
    }

    return head;
}