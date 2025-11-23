bool canReach(int targetX, int targetY, int time) {
    int sum = abs(targetX) + abs(targetY);
    return sum <= time && (time - sum) % 2 == 0;
}