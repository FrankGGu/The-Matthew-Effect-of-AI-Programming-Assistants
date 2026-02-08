int lastRemaining(int n) {
    int left = 1, step = 1, remaining = n;
    int isLeft = 1;

    while (remaining > 1) {
        if (isLeft || remaining % 2 == 1) {
            left += step;
        }
        step *= 2;
        remaining /= 2;
        isLeft = !isLeft;
    }

    return left;
}