int minSteps(char* s, char* t) {
    int count[26] = {0};

    while (*s) {
        count[*s - 'a']++;
        count[*t - 'a']--;
        s++;
        t++;
    }

    int steps = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            steps += count[i];
        }
    }

    return steps;
}