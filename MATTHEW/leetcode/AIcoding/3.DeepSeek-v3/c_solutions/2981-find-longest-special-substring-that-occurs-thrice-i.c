typedef struct {
    char* s;
    int len;
} Substring;

int cmp(const void* a, const void* b) {
    Substring* sa = (Substring*)a;
    Substring* sb = (Substring*)b;
    if (sa->len != sb->len) {
        return sb->len - sa->len;
    }
    return strcmp(sa->s, sb->s);
}

int maximumLength(char* s) {
    int n = strlen(s);
    int total = n * (n + 1) / 2;
    Substring* subs = (Substring*)malloc(total * sizeof(Substring));
    int idx = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int len = j - i + 1;
            char* sub = (char*)malloc((len + 1) * sizeof(char));
            strncpy(sub, s + i, len);
            sub[len] = '\0';
            subs[idx].s = sub;
            subs[idx].len = len;
            idx++;
        }
    }

    qsort(subs, total, sizeof(Substring), cmp);

    int max_len = -1;
    for (int i = 0; i < total; i++) {
        if (i + 2 < total && 
            subs[i].len == subs[i+1].len && subs[i].len == subs[i+2].len &&
            strcmp(subs[i].s, subs[i+1].s) == 0 && 
            strcmp(subs[i+1].s, subs[i+2].s) == 0) {
            max_len = subs[i].len;
            break;
        }
    }

    for (int i = 0; i < total; i++) {
        free(subs[i].s);
    }
    free(subs);

    return max_len;
}