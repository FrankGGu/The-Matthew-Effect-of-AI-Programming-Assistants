int minimumChairs(char* s) {
    int max_chairs = 0;
    int current = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'E') {
            current++;
        } else {
            current--;
        }

        if (current > max_chairs) {
            max_chairs = current;
        }
    }

    return max_chairs;
}