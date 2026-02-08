char *gcdOfStrings(char *str1, char *str2) {
    int len1 = strlen(str1), len2 = strlen(str2);
    if (len1 < len2) {
        return gcdOfStrings(str2, str1);
    }
    if (len2 == 0) {
        return str1;
    }
    if (strncmp(str1, str2, len2) == 0) {
        return gcdOfStrings(str1 + len2, str2);
    }
    return "";
}