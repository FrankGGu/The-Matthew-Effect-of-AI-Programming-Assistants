int distance(int a, int b) {
    return a > b ? a - b : b - a;
}

int findClosestPerson(int x, int y, int z) {
    int dist1 = distance(x, z);
    int dist2 = distance(y, z);

    if (dist1 < dist2) {
        return 1;
    } else if (dist2 < dist1) {
        return 2;
    } else {
        return 0;
    }
}