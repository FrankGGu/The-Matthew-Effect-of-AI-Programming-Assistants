int bestClosingTime(char* customers) {
    int n = strlen(customers);
    int penalty = 0;
    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            penalty++;
        }
    }

    int min_penalty = penalty;
    int hour = 0;
    int current = penalty;

    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            current--;
        } else {
            current++;
        }

        if (current < min_penalty) {
            min_penalty = current;
            hour = i + 1;
        }
    }

    return hour;
}