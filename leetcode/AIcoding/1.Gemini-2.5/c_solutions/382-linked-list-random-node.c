#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

typedef struct {
    int* values;
    int size;
} Solution;

Solution* solutionCreate(struct ListNode* head) {
    Solution* obj = (Solution*) malloc(sizeof(Solution));
    obj->values = NULL;
    obj->size = 0;

    // First pass to count the nodes
    struct ListNode* current = head;
    while (current != NULL) {
        obj->size++;
        current = current->next;
    }

    // Allocate memory for the array of values
    obj->values = (int*) malloc(sizeof(int) * obj->size);

    // Second pass to store the values in the array
    current = head;
    int i = 0;
    while (current != NULL) {
        obj->values[i++] = current->val;
        current = current->next;
    }

    return obj;
}

int solutionGetRandom(Solution* obj) {
    // Generate a random index within the bounds of the array
    int randomIndex = rand() % obj->size;
    return obj->values[randomIndex];
}

void solutionFree(Solution* obj) {
    free(obj->values); // Free the dynamically allocated array
    free(obj);         // Free the Solution object itself
}