#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int score;
} Student;

int compare(const void *a, const void *b) {
    Student *studentA = (Student *)a;
    Student *studentB = (Student *)b;
    if (studentA->score != studentB->score) {
        return studentB->score - studentA->score;
    } else {
        return studentA->id - studentB->id;
    }
}

int* rewardTopK(char** positive_feedback, int positive_feedbackSize, char** negative_feedback, int negative_feedbackSize, char** report, int reportSize, int* student_id, int student_idSize, int k, int* returnSize) {
    int* scores = (int*)malloc(sizeof(int) * student_idSize);
    for (int i = 0; i < student_idSize; i++) {
        scores[i] = 0;
        char* token = strtok(report[i], " ");
        while (token != NULL) {
            int foundPositive = 0;
            for (int j = 0; j < positive_feedbackSize; j++) {
                if (strcmp(token, positive_feedback[j]) == 0) {
                    scores[i] += 3;
                    foundPositive = 1;
                    break;
                }
            }
            if (!foundPositive) {
                for (int j = 0; j < negative_feedbackSize; j++) {
                    if (strcmp(token, negative_feedback[j]) == 0) {
                        scores[i] -= 1;
                        break;
                    }
                }
            }
            token = strtok(NULL, " ");
        }
    }

    Student* students = (Student*)malloc(sizeof(Student) * student_idSize);
    for (int i = 0; i < student_idSize; i++) {
        students[i].id = student_id[i];
        students[i].score = scores[i];
    }

    qsort(students, student_idSize, sizeof(Student), compare);

    int* result = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        result[i] = students[i].id;
    }

    *returnSize = k;

    free(scores);
    free(students);
    return result;
}