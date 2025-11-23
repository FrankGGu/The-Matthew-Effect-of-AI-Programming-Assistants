/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int id;
    int score;
} Student;

int cmp(const void* a, const void* b) {
    Student* s1 = (Student*)a;
    Student* s2 = (Student*)b;
    if (s1->score == s2->score) {
        return s1->id - s2->id;
    }
    return s2->score - s1->score;
}

int* topStudents(char** positive_feedback, int positive_feedbackSize, 
                 char** negative_feedback, int negative_feedbackSize, 
                 char** report, int reportSize, 
                 int* student_id, int student_idSize, int k, int* returnSize) {
    *returnSize = k;
    int* res = (int*)malloc(k * sizeof(int));

    Student* students = (Student*)malloc(reportSize * sizeof(Student));

    for (int i = 0; i < reportSize; i++) {
        students[i].id = student_id[i];
        students[i].score = 0;

        char* token = strtok(report[i], " ");
        while (token != NULL) {
            for (int j = 0; j < positive_feedbackSize; j++) {
                if (strcmp(token, positive_feedback[j]) == 0) {
                    students[i].score += 3;
                    break;
                }
            }
            for (int j = 0; j < negative_feedbackSize; j++) {
                if (strcmp(token, negative_feedback[j]) == 0) {
                    students[i].score -= 1;
                    break;
                }
            }
            token = strtok(NULL, " ");
        }
    }

    qsort(students, reportSize, sizeof(Student), cmp);

    for (int i = 0; i < k; i++) {
        res[i] = students[i].id;
    }

    free(students);
    return res;
}