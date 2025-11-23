#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int students;
    int total;
} Student;

int compare(const void *a, const void *b) {
    Student *s1 = (Student *)a;
    Student *s2 = (Student *)b;
    double r1 = (double)(s1->students + 1) / (s1->total + 1) - (double)s1->students / s1->total;
    double r2 = (double)(s2->students + 1) / (s2->total + 1) - (double)s2->students / s2->total;
    if (r1 > r2) return -1;
    if (r1 < r2) return 1;
    return 0;
}

double maxAverage(int* classes, int classesSize, int k) {
    Student *students = (Student *)malloc(classesSize * sizeof(Student));
    for (int i = 0; i < classesSize; i++) {
        students[i].students = classes[2 * i];
        students[i].total = classes[2 * i + 1];
    }

    qsort(students, classesSize, sizeof(Student), compare);

    for (int i = 0; i < k; i++) {
        students[i].students++;
        students[i].total++;
    }

    double total = 0;
    for (int i = 0; i < classesSize; i++) {
        total += (double)students[i].students / students[i].total;
    }

    free(students);
    return total / classesSize;
}