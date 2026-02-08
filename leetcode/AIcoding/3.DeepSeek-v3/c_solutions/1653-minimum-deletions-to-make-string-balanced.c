int minimumDeletions(char* s) {
    int a_count = 0;
    int b_count = 0;
    int result = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'a') {
            a_count++;
        }
    }

    result = a_count;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'a') {
            a_count--;
        } else {
            b_count++;
        }
        if (a_count + b_count < result) {
            result = a_count + b_count;
        }
    }

    return result;
}