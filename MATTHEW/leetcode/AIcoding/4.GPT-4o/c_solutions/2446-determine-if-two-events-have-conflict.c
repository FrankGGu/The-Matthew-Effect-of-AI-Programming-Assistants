bool haveConflict(char **event1, int event1Size, char **event2, int event2Size) {
    int start1 = atoi(event1[0] + 0) * 60 + atoi(event1[0] + 3);
    int end1 = atoi(event1[1] + 0) * 60 + atoi(event1[1] + 3);
    int start2 = atoi(event2[0] + 0) * 60 + atoi(event2[0] + 3);
    int end2 = atoi(event2[1] + 0) * 60 + atoi(event2[1] + 3);

    return !(end1 <= start2 || end2 <= start1);
}