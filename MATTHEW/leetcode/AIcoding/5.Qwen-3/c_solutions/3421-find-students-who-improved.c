#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* student_id;
    int old_score;
    int new_score;
} Student;

typedef struct {
    char* student_id;
    int old_score;
    int new_score;
} Result;

int compare(const void* a, const void* b) {
    return strcmp(((Student*)a)->student_id, ((Student*)b)->student_id);
}

Result* findStudentsWhoImproved(Student** students, int studentsSize, int* returnSize) {
    Result* result = (Result*)malloc(studentsSize * sizeof(Result));
    int count = 0;

    for (int i = 0; i < studentsSize; i++) {
        if (students[i]->old_score < students[i]->new_score) {
            result[count].student_id = strdup(students[i]->student_id);
            result[count].old_score = students[i]->old_score;
            result[count].new_score = students[i]->new_score;
            count++;
        }
    }

    qsort(result, count, sizeof(Result), compare);
    *returnSize = count;
    return result;
}