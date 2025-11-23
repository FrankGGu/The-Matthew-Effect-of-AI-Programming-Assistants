int maxNumberOfGroups(int* grades, int gradesSize) {
    int total = 0;
    int group = 1;

    while (gradesSize >= group) {
        total += group;
        group++;
        gradesSize -= group;
    }

    return group - 1;
}