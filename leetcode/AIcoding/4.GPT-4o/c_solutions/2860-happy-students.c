int getStudents(int* students, int studentsSize) {
    int happyCount = 0;
    for (int i = 0; i < studentsSize; i++) {
        int satisfied = 1;
        for (int j = 0; j < studentsSize; j++) {
            if (students[i] < students[j]) {
                satisfied = 0;
                break;
            }
        }
        happyCount += satisfied;
    }
    return happyCount;
}