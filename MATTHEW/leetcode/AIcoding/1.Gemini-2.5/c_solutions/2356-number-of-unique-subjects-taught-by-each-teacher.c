#include <stdlib.h>

int compareTeacherSubject(const void* a, const void* b) {
    const int* teacherSubjectA = *(const int**)a;
    const int* teacherSubjectB = *(const int**)b;

    if (teacherSubjectA[0] != teacherSubjectB[0]) {
        return teacherSubjectA[0] - teacherSubjectB[0];
    }
    return teacherSubjectA[1] - teacherSubjectB[1];
}

int** getUniqueSubjectsTaught(int** teachers, int teachersSize, int* teachersColSize, int* returnSize, int** returnColumnSizes) {
    if (teachersSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Sort the input array by teacher_id, then by subject_id.
    qsort(teachers, teachersSize, sizeof(int*), compareTeacherSubject);

    int** result = NULL;
    int currentResultCapacity = 0;
    int currentResultSize = 0;

    int* colSizes = NULL;
    int currentColSizesCapacity = 0;

    // Initialize tracking variables for the first teacher.
    int currentTeacherId = teachers[0][0];
    int uniqueSubjectsCount = 0;
    int lastSubjectId = -1; // Assuming subject_ids are non-negative.

    for (int i = 0; i < teachersSize; ++i) {
        int teacherId = teachers[i][0];
        int subjectId = teachers[i][1];

        if (teacherId == currentTeacherId) {
            // Same teacher, check for unique subject.
            if (subjectId != lastSubjectId) {
                uniqueSubjectsCount++;
                lastSubjectId = subjectId;
            }
        } else {
            // New teacher encountered, store results for the previous teacher.
            if (currentResultSize == currentResultCapacity) {
                currentResultCapacity = (currentResultCapacity == 0) ? 1 : currentResultCapacity * 2;
                result = (int**)realloc(result, currentResultCapacity * sizeof(int*));
                colSizes = (int*)realloc(colSizes, currentResultCapacity * sizeof(int));
                if (result == NULL || colSizes == NULL) {
                    // Handle realloc failure
                    for (int j = 0; j < currentResultSize; ++j) {
                        free(result[j]);
                    }
                    free(result);
                    free(colSizes);
                    *returnSize = 0;
                    *returnColumnSizes = NULL;
                    return NULL;
                }
            }

            // Store the result for the previous teacher.
            result[currentResultSize] = (int*)malloc(2 * sizeof(int));
            if (result[currentResultSize] == NULL) {
                 for (int j = 0; j < currentResultSize; ++j) {
                    free(result[j]);
                 }
                 free(result);
                 free(colSizes);
                 *returnSize = 0;
                 *returnColumnSizes = NULL;
                 return NULL;
            }
            result[currentResultSize][0] = currentTeacherId;
            result[currentResultSize][1] = uniqueSubjectsCount;
            colSizes[currentResultSize] = 2;
            currentResultSize++;

            // Reset for the new teacher.
            currentTeacherId = teacherId;
            uniqueSubjectsCount = 1; // The current subject is the first unique subject for this new teacher.
            lastSubjectId = subjectId;
        }
    }

    // Store the result for the last teacher.
    if (currentResultSize == currentResultCapacity) {
        // Just add 1 capacity for the last element if needed.
        currentResultCapacity = (currentResultCapacity == 0) ? 1 : currentResultCapacity + 1;
        result = (int**)realloc(result, currentResultCapacity * sizeof(int*));
        colSizes = (int*)realloc(colSizes, currentResultCapacity * sizeof(int));
        if (result == NULL || colSizes == NULL) {
            for (int j = 0; j < currentResultSize; ++j) {
                free(result[j]);
            }
            free(result);
            free(colSizes);
            *returnSize = 0;
            *returnColumnSizes = NULL;
            return NULL;
        }
    }
    result[currentResultSize] = (int*)malloc(2 * sizeof(int));
    if (result[currentResultSize] == NULL) {
        for (int j = 0; j < currentResultSize; ++j) {
            free(result[j]);
        }
        free(result);
        free(colSizes);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    result[currentResultSize][0] = currentTeacherId;
    result[currentResultSize][1] = uniqueSubjectsCount;
    colSizes[currentResultSize] = 2;
    currentResultSize++;

    *returnSize = currentResultSize;
    *returnColumnSizes = colSizes;
    return result;
}