bool rotateString(char *s, char *goal) {
    int lenS = strlen(s);
    int lenGoal = strlen(goal);
    if (lenS != lenGoal) return false;
    char *concat = (char *)malloc(2 * lenS + 1);
    strcpy(concat, s);
    strcat(concat, s);
    bool result = strstr(concat, goal) != NULL;
    free(concat);
    return result;
}