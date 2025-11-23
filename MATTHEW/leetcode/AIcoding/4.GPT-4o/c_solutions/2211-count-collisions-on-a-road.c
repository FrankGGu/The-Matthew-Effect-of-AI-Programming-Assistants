int countCollisions(char *directions) {
    int count = 0, n = strlen(directions);
    for (int i = 0; i < n; i++) {
        if (directions[i] == 'S') continue;
        if (i > 0 && directions[i] == 'R' && directions[i-1] == 'L') {
            count += 2;
            directions[i] = 'S';
            directions[i-1] = 'S';
        } else if (i > 0 && directions[i] == 'L' && directions[i-1] == 'R') {
            count += 2;
            directions[i] = 'S';
            directions[i-1] = 'S';
        }
    }
    for (int i = 0; i < n; i++) {
        if (directions[i] == 'R') {
            for (int j = i + 1; j < n; j++) {
                if (directions[j] == 'L') {
                    count += 2;
                    directions[i] = 'S';
                    directions[j] = 'S';
                    break;
                }
            }
        }
    }
    return count;
}