#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct WordFeedback {
    char* word;
    bool is_positive;
    bool is_negative;
    struct WordFeedback* next;
} WordFeedback;

#define HASH_TABLE_SIZE 20000
WordFeedback* feedbackHashTable[HASH_TABLE_SIZE];

unsigned int hash(const char *str) {
    unsigned int h = 5381;
    int c;
    while ((c = *str++)) {
        h = ((h << 5) + h) + c;
    }
    return h % HASH_TABLE_SIZE;
}

void initHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        feedbackHashTable[i] = NULL;
    }
}

void addFeedbackWord(const char* word, bool is_pos, bool is_neg) {
    unsigned int idx = hash(word);
    WordFeedback* current = feedbackHashTable[idx];
    while (current != NULL) {
        if (strcmp(current->word, word) == 0) {
            if (is_pos) current->is_positive = true;
            if (is_neg) current->is_negative = true;
            return;
        }
        current = current->next;
    }
    WordFeedback* newNode = (WordFeedback*)malloc(sizeof(WordFeedback));
    newNode->word = strdup(word);
    newNode->is_positive = is_pos;
    newNode->is_negative = is_neg;
    newNode->next = feedbackHashTable[idx];
    feedbackHashTable[idx] = newNode;
}

int calculateWordScore(const char* word) {
    unsigned int idx = hash(word);
    WordFeedback* current = feedbackHashTable[idx];
    while (current != NULL) {
        if (strcmp(current->word, word) == 0) {
            int score = 0;
            if (current->is_positive) score += 3;
            if (current->is_negative) score -= 1;
            return score;
        }
        current = current->next;
    }
    return 0;
}

void freeHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        WordFeedback* current = feedbackHashTable[i];
        while (current != NULL) {
            WordFeedback* temp = current;
            current = current->next;
            free(temp->word);
            free(temp);
        }
        feedbackHashTable[i] = NULL;
    }
}

typedef struct Student {
    int id;
    int score;
} Student;

int compareStudents(const void* a, const void* b) {
    Student* s1 = (Student*)a;
    Student* s2 = (Student*)b;
    if (s1->score != s2->score) {
        return s2->score - s1->score;
    }
    return s1->id - s2->id;
}

int* rewardStudents(char** report, int reportSize, int* student_id, int student_idSize,
                    char** positive_feedback, int positive_feedbackSize,
                    char** negative_feedback, int negative_feedbackSize, int k, int* returnSize) {

    initHashTable();

    for (int i = 0; i < positive_feedbackSize; ++i) {
        addFeedbackWord(positive_feedback[i], true, false);
    }

    for (int i = 0; i < negative_feedbackSize; ++i) {
        addFeedbackWord(negative_feedback[i], false, true);
    }

    Student* students = (Student*)malloc(reportSize * sizeof(Student));

    for (int i = 0; i < reportSize; ++i) {
        students[i].id = student_id[i];
        students[i].score = 0;

        char* report_copy = strdup(report[i]);
        char* rest = report_copy;
        char* token;

        while ((token = strtok_r(rest, " ", &rest))) {
            students[i].score += calculateWordScore(token);
        }
        free(report_copy);
    }

    qsort(students, reportSize, sizeof(Student), compareStudents);

    *returnSize = k;
    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; ++i) {
        result[i] = students[i].id;
    }

    free(students);
    freeHashTable();

    return result;
}