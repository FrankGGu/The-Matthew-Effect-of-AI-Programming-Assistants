int calculateDirection(int direction, char instruction) {
    if (instruction == 'L') {
        return (direction + 3) % 4;
    } else if (instruction == 'R') {
        return (direction + 1) % 4;
    }
    return direction;
}

bool isRobotBounded(char* instructions) {
    int x = 0, y = 0;
    int direction = 0;
    int dx[4] = {0, 1, 0, -1};
    int dy[4] = {1, 0, -1, 0};

    for (int i = 0; instructions[i] != '\0'; i++) {
        char c = instructions[i];
        if (c == 'G') {
            x += dx[direction];
            y += dy[direction];
        } else {
            direction = calculateDirection(direction, c);
        }
    }

    return (x == 0 && y == 0) || direction != 0;
}