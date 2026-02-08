int minPushes(char *target) {
    int pushes = 0;
    char prev = ' ';

    for (int i = 0; target[i] != '\0'; i++) {
        if (target[i] != prev) {
            pushes++;
            prev = target[i];
        }
    }

    return pushes;
}