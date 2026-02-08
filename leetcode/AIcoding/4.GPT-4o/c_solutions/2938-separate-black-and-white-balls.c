void sortBalls(int* balls, int ballsSize) {
    int blackIndex = 0, whiteIndex = 0;

    while (whiteIndex < ballsSize) {
        if (balls[whiteIndex] == 0) {
            int temp = balls[blackIndex];
            balls[blackIndex] = balls[whiteIndex];
            balls[whiteIndex] = temp;
            blackIndex++;
        }
        whiteIndex++;
    }
}