int minimumDeletions(char *s) {
    int count_a = 0, count_b = 0, deletions = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'a') {
            count_a++;
        } else {
            count_b++;
        }
        if (count_b > count_a) {
            deletions++;
            count_b--;
        }
    }

    return deletions + count_b;
}