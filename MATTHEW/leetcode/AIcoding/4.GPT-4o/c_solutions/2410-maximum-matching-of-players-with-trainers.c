int maxStudents(int* students, int studentsSize, int* trainers, int trainersSize) {
    int i, j, count = 0;
    qsort(students, studentsSize, sizeof(int), cmp);
    qsort(trainers, trainersSize, sizeof(int), cmp);

    i = 0;
    for (j = 0; j < trainersSize && i < studentsSize; j++) {
        if (students[i] <= trainers[j]) {
            count++;
            i++;
        }
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}