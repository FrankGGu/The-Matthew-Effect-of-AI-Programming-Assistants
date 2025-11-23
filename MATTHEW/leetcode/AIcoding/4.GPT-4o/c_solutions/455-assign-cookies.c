int findContentChildren(int* g, int gSize, int* s, int sSize) {
    qsort(g, gSize, sizeof(int), cmp);
    qsort(s, sSize, sizeof(int), cmp);

    int contentChildren = 0;
    int cookieIndex = 0;

    while (contentChildren < gSize && cookieIndex < sSize) {
        if (s[cookieIndex] >= g[contentChildren]) {
            contentChildren++;
        }
        cookieIndex++;
    }

    return contentChildren;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}