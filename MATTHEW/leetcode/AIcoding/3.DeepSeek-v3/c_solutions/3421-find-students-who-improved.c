#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char name[21];
    int score1;
    int score2;
} Student;

int compare(const void* a, const void* b) {
    Student* s1 = (Student*)a;
    Student* s2 = (Student*)b;
    return strcmp(s1->name, s2->name);
}

char** findStudents(int** scores, int scoresSize, int* scoresColSize, int* returnSize) {
    Student* students = (Student*)malloc(scoresSize * sizeof(Student));

    for (int i = 0; i < scoresSize; i++) {
        strcpy(students[i].name, (char*)scores[i][0]);
        students[i].score1 = scores[i][1];
        students[i].score2 = scores[i][2];
    }

    qsort(students, scoresSize, sizeof(Student), compare);

    char** result = (char**)malloc(scoresSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < scoresSize; i++) {
        if (students[i].score2 > students[i].score1) {
            result[*returnSize] = (char*)malloc(21 * sizeof(char));
            strcpy(result[*returnSize], students[i].name);
            (*returnSize)++;
        }
    }

    free(students);
    return result;
}