char* capitalizeTitle(char* title) {
    int i = 0;
    int start = 0;
    int len = 0;

    while (title[i]) {
        if (title[i] == ' ') {
            if (len > 2) {
                if (title[start] >= 'a' && title[start] <= 'z') {
                    title[start] = title[start] - 'a' + 'A';
                }
            }
            start = i + 1;
            len = 0;
        } else {
            if (title[i] >= 'A' && title[i] <= 'Z') {
                title[i] = title[i] - 'A' + 'a';
            }
            len++;
        }
        i++;
    }

    if (len > 2) {
        if (title[start] >= 'a' && title[start] <= 'z') {
            title[start] = title[start] - 'a' + 'A';
        }
    }

    return title;
}