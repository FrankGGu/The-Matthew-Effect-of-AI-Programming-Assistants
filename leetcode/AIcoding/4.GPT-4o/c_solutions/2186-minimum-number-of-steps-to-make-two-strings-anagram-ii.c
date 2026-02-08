int minSteps(char * s, char * t) {
    int count[26] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }
    for (int i = 0; t[i]; i++) {
        count[t[i] - 'a']--;
    }
    int steps = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            steps += count[i];
        }
    }
    return steps;
}