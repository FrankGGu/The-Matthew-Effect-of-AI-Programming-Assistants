char* capitalizeTitle(char* title) {
    int i = 0;
    int start = 0;
    int len = strlen(title);

    while (i <= len) {
        if (i == len || title[i] == ' ') {
            int wordLen = i - start;
            if (wordLen > 2) {
                if (title[start] >= 'a' && title[start] <= 'z') {
                    title[start] = title[start] - 'a' + 'A';
                }
                for (int j = start + 1; j < i; j++) {
                    if (title[j] >= 'A' && title[j] <= 'Z') {
                        title[j] = title[j] - 'A' + 'a';
                    }
                }
            } else {
                for (int j = start; j < i; j++) {
                    if (title[j] >= 'A' && title[j] <= 'Z') {
                        title[j] = title[j] - 'A' + 'a';
                    }
                }
            }
            start = i + 1;
        }
        i++;
    }

    return title;
}