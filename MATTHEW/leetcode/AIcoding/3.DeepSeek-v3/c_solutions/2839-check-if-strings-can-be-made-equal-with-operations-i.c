bool canBeEqual(char* s1, char* s2) {
    if (strcmp(s1, s2) == 0) return true;

    char temp;

    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp;
    if (strcmp(s1, s2) == 0) return true;
    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp;

    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp;
    if (strcmp(s1, s2) == 0) return true;
    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp;

    temp = s1[0];
    s1[0] = s1[2];
    s1[2] = temp;
    temp = s1[1];
    s1[1] = s1[3];
    s1[3] = temp;
    if (strcmp(s1, s2) == 0) return true;

    return false;
}