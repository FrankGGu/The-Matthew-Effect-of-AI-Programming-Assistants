bool isSubStrReverse(char *s, char *sub) {
    int lenS = strlen(s);
    int lenSub = strlen(sub);

    for (int i = 0; i <= lenS - lenSub; i++) {
        if (strncmp(s + i, sub, lenSub) == 0 || strncmp(s + i, sub + lenSub - 1, lenSub) == 0) {
            return true;
        }
    }
    return false;
}