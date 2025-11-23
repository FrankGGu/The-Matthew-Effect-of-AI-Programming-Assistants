int maximumScore(char *s1, char *s2, char *s3) {
    int count[26] = {0};
    for (int i = 0; s1[i]; i++) count[s1[i] - 'a']++;
    for (int i = 0; s2[i]; i++) count[s2[i] - 'a']++;
    for (int i = 0; s3[i]; i++) count[s3[i] - 'a']++;

    int score = 0;

    for (int i = 0; i < 26; i++) {
        while (count[i] >= 2) {
            score += (i + 1);
            count[i] -= 2;
        }
    }

    return score;
}