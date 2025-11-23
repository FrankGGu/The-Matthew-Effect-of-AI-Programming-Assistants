#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memcpy

typedef struct {
    int student_id;
    char *student_name;
} Student;

typedef struct {
    int student_id;
    int course_id;
    int score;
    int exam_type; // 0 for Midterm, 1 for Final
} Score;

int compareScores(const void* a, const void* b) {
    Score* scoreA = (Score*)a;
    Score* scoreB = (Score*)b;

    if (scoreA->student_id != scoreB->student_id) {
        return scoreA->student_id - scoreB->student_id;
    }
    if (scoreA->course_id != scoreB->course_id) {
        return scoreA->course_id - scoreB->course_id;
    }
    return scoreA->exam_type - scoreB->exam_type; // Midterm (0) before Final (1)
}

int compareInts(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* findImprovedStudents(Student* students, int studentsSize, Score* scores, int scoresSize, int* returnSize) {
    qsort(scores, scoresSize, sizeof(Score), compareScores);

    int* temp_improved_students = (int*)malloc(scoresSize * sizeof(int));
    if (temp_improved_students == NULL) {
        *returnSize = 0;
        return NULL;
    }
    int temp_count = 0;

    for (int i = 0; i < scoresSize - 1; ++i) {
        if (scores[i].student_id == scores[i+1].student_id &&
            scores[i].course_id == scores[i+1].course_id &&
            scores[i].exam_type == 0 && // Midterm
            scores[i+1].exam_type == 1) { // Final

            if (scores[i+1].score > scores[i].score) {
                temp_improved_students[temp_count++] = scores[i].student_id;
            }
        }
    }

    if (temp_count == 0) {
        free(temp_improved_students);
        *returnSize = 0;
        return NULL;
    }

    qsort(temp_improved_students, temp_count, sizeof(int), compareInts);

    int unique_count = 0;
    if (temp_count > 0) {
        temp_improved_students[unique_count++] = temp_improved_students[0];
        for (int i = 1; i < temp_count; ++i) {
            if (temp_improved_students[i] != temp_improved_students[i-1]) {
                temp_improved_students[unique_count++] = temp_improved_students[i];
            }
        }
    }

    int* result = (int*)malloc(unique_count * sizeof(int));
    if (result == NULL) {
        free(temp_improved_students);
        *returnSize = 0;
        return NULL;
    }

    memcpy(result, temp_improved_students, unique_count * sizeof(int));

    free(temp_improved_students);

    *returnSize = unique_count;
    return result;
}