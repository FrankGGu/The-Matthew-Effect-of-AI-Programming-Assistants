#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** uniqueSubjects(int** teacher, int teacherSize, int* teacherColSize, int* returnSize, int** returnColumnSizes) {
    int **result = malloc(teacherSize * sizeof(int*));
    *returnColumnSizes = malloc(teacherSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < teacherSize; i++) {
        int teacher_id = teacher[i][0];
        int subject_id = teacher[i][1];

        // Find if this teacher already exists in result
        int found = -1;
        for (int j = 0; j < *returnSize; j++) {
            if (result[j][0] == teacher_id) {
                found = j;
                break;
            }
        }

        if (found == -1) {
            // New teacher - create entry with initial subject
            result[*returnSize] = malloc(2 * sizeof(int));
            result[*returnSize][0] = teacher_id;
            result[*returnSize][1] = subject_id;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        } else {
            // Existing teacher - check if subject is new
            int exists = 0;
            for (int k = 1; k < (*returnColumnSizes)[found]; k++) {
                if (result[found][k] == subject_id) {
                    exists = 1;
                    break;
                }
            }
            if (!exists) {
                // Add new subject
                int new_size = (*returnColumnSizes)[found] + 1;
                result[found] = realloc(result[found], new_size * sizeof(int));
                result[found][new_size - 1] = subject_id;
                (*returnColumnSizes)[found] = new_size;
            }
        }
    }

    // Prepare final output: teacher_id, count
    int **final = malloc(*returnSize * sizeof(int*));
    *returnColumnSizes = realloc(*returnColumnSizes, *returnSize * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        final[i] = malloc(2 * sizeof(int));
        final[i][0] = result[i][0];
        final[i][1] = (*returnColumnSizes)[i] - 1; // subtract teacher_id
        (*returnColumnSizes)[i] = 2;

        free(result[i]);
    }
    free(result);

    return final;
}