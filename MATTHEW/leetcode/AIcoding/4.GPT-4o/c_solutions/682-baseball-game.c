int calPoints(char ** ops, int opsSize) {
    int points[opsSize];
    int count = 0;

    for (int i = 0; i < opsSize; i++) {
        if (ops[i][0] == 'C') {
            count--;
        } else if (ops[i][0] == 'D') {
            points[count] = points[count - 1] * 2;
            count++;
        } else if (ops[i][0] == '+') {
            points[count] = points[count - 1] + points[count - 2];
            count++;
        } else {
            points[count] = atoi(ops[i]);
            count++;
        }
    }

    int total = 0;
    for (int i = 0; i < count; i++) {
        total += points[i];
    }

    return total;
}