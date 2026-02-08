int maximumRemovals(char *s, char *p, int* removable, int removableSize) {
    int left = 0, right = removableSize, answer = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        char temp[strlen(s) + 1];
        strcpy(temp, s);

        for (int i = 0; i < mid; i++) {
            temp[removable[i]] = '\0';
        }

        int j = 0;
        for (int i = 0; temp[i]; i++) {
            if (temp[i] == p[j]) {
                j++;
            }
            if (p[j] == '\0') break;
        }

        if (p[j] == '\0') {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
}