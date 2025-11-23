#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char subject[100];
} Subject;

typedef struct {
    char teacher_id[100];
    int count;
} TeacherSubjectCount;

int compare(const void *a, const void *b) {
    return strcmp(((TeacherSubjectCount *)a)->teacher_id, ((TeacherSubjectCount *)b)->teacher_id);
}

int compare_subjects(const void *a, const void *b) {
    return strcmp(((Subject *)a)->subject, ((Subject *)b)->subject);
}

int uniqueSubjects(char **teachers, int teachersSize, char **subjects, int subjectsSize, char ***result) {
    int *count = (int *)calloc(teachersSize, sizeof(int));
    int *index = (int *)calloc(teachersSize, sizeof(int));

    for (int i = 0; i < subjectsSize; i++) {
        char *teacher_id = strtok(subjects[i], ",");
        char *subject = strtok(NULL, ",");

        int found = 0;
        for (int j = 0; j < teachersSize; j++) {
            if (strcmp(teachers[j], teacher_id) == 0) {
                found = 1;
                int exists = 0;
                for (int k = 0; k < index[j]; k++) {
                    if (strcmp(subjects[k], subject) == 0) {
                        exists = 1;
                        break;
                    }
                }
                if (!exists) {
                    count[j]++;
                    index[j]++;
                }
                break;
            }
        }
    }

    int resultSize = 0;
    for (int i = 0; i < teachersSize; i++) {
        if (count[i] > 0) {
            resultSize++;
        }
    }

    *result = (char **)malloc(resultSize * sizeof(char *));
    int idx = 0;

    for (int i = 0; i < teachersSize; i++) {
        if (count[i] > 0) {
            (*result)[idx] = (char *)malloc(20 * sizeof(char));
            sprintf((*result)[idx], "%s %d", teachers[i], count[i]);
            idx++;
        }
    }

    free(count);
    free(index);
    return resultSize;
}