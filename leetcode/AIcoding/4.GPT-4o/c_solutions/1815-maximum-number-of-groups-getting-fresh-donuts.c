int maxGroups(int* grades, int gradesSize) {
    int groupCount = 0, totalStudents = 0;
    while (totalStudents + groupCount + 1 <= gradesSize) {
        groupCount++;
        totalStudents += groupCount;
    }
    return groupCount;
}