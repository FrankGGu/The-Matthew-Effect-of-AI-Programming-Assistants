int magicalString(int n) {
    if (n == 0) return 0;
    if (n <= 3) return 1;

    int count = 1, index = 2;
    int magical[100050] = {1, 2, 2}; // Initialize the first three elements

    while (index < n) {
        int length = magical[index - 1];
        int nextValue = (magical[index - 2] == 1) ? 2 : 1;
        for (int i = 0; i < length && index < n; i++, index++) {
            magical[index] = nextValue;
            if (nextValue == 1) count++;
        }
    }

    return count;
}