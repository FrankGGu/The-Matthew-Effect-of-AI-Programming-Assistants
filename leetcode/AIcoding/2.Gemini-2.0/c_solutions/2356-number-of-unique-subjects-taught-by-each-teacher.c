#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Result {
    int teacher_id;
    int num_unique_subjects;
};

int compare(const void *a, const void *b) {
    return ((struct Result*)a)->teacher_id - ((struct Result*)b)->teacher_id;
}

struct Result* solve(int teacher_id[], int subject_id[], int n, int* returnSize) {
    int max_teacher_id = 0;
    for (int i = 0; i < n; i++) {
        if (teacher_id[i] > max_teacher_id) {
            max_teacher_id = teacher_id[i];
        }
    }

    int* subject_counts = (int*)calloc(max_teacher_id + 1, sizeof(int));
    int* subject_sets = (int*)calloc(max_teacher_id + 1, sizeof(int));

    for (int i = 0; i < n; i++) {
        int teacher = teacher_id[i];
        int subject = subject_id[i];

        int mask = 1 << (subject % 32);
        if (!(subject_sets[teacher] & mask)) {
            subject_sets[teacher] |= mask;
            subject_counts[teacher]++;
        }
    }

    int count = 0;
    for (int i = 1; i <= max_teacher_id; i++) {
        if (subject_counts[i] > 0) {
            count++;
        }
    }

    struct Result* results = (struct Result*)malloc(count * sizeof(struct Result));
    int index = 0;
    for (int i = 1; i <= max_teacher_id; i++) {
        if (subject_counts[i] > 0) {
            results[index].teacher_id = i;
            results[index].num_unique_subjects = subject_counts[i];
            index++;
        }
    }

    qsort(results, count, sizeof(struct Result), compare);

    free(subject_counts);
    free(subject_sets);

    *returnSize = count;
    return results;
}