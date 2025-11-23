bool canTransform(char *start, char *end) {
    int i = 0, j = 0;
    while (i < strlen(start) || j < strlen(end)) {
        while (i < strlen(start) && start[i] == 'X') i++;
        while (j < strlen(end) && end[j] == 'X') j++;
        if (i == strlen(start) && j == strlen(end)) break;
        if (i == strlen(start) || j == strlen(end) || start[i] != end[j]) return false;
        if (start[i] == 'L' && i < j) return false;
        if (start[i] == 'R' && i > j) return false;
        i++;
        j++;
    }
    return true;
}