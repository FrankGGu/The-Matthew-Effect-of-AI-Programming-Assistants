int countCollisions(char* directions) {
    int collisions = 0;
    int n = strlen(directions);
    int left = 0, right = n - 1;

    while (left < n && directions[left] == 'L') {
        left++;
    }

    while (right >= 0 && directions[right] == 'R') {
        right--;
    }

    for (int i = left; i <= right; i++) {
        if (directions[i] != 'S') {
            collisions++;
        }
    }

    return collisions;
}