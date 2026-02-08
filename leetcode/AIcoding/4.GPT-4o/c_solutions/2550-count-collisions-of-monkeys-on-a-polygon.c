int countCollisions(char * directions, int directionsSize) {
    int count = 0;
    int i = 0;

    while (i < directionsSize) {
        if (directions[i] == 'R') {
            int j = i;
            while (j < directionsSize && directions[j] == 'R') j++;
            if (j < directionsSize && directions[j] == 'S') {
                count += j - i + 1;
                directions[i] = 'S';
                for (int k = i + 1; k <= j; k++) {
                    directions[k] = 'S';
                }
            }
            i = j;
        } else if (directions[i] == 'L') {
            int j = i;
            while (j >= 0 && directions[j] == 'L') j--;
            if (j >= 0 && directions[j] == 'S') {
                count += i - j + 1;
                directions[j] = 'S';
                for (int k = j + 1; k <= i; k++) {
                    directions[k] = 'S';
                }
            }
            i++;
        } else {
            i++;
        }
    }

    return count;
}