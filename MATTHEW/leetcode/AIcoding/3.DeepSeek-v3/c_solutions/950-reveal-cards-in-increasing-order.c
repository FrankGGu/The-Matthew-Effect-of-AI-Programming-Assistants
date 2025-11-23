/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* deckRevealedIncreasing(int* deck, int deckSize, int* returnSize) {
    *returnSize = deckSize;
    if (deckSize == 0) return NULL;

    int* result = (int*)malloc(deckSize * sizeof(int));
    int* indices = (int*)malloc(deckSize * sizeof(int));

    for (int i = 0; i < deckSize; i++) {
        indices[i] = i;
    }

    // Sort the deck
    for (int i = 0; i < deckSize - 1; i++) {
        for (int j = i + 1; j < deckSize; j++) {
            if (deck[i] > deck[j]) {
                int temp = deck[i];
                deck[i] = deck[j];
                deck[j] = temp;
            }
        }
    }

    // Simulate the process
    int front = 0, rear = deckSize - 1;
    for (int i = 0; i < deckSize; i++) {
        result[indices[front]] = deck[i];
        front++;

        if (front <= rear) {
            indices[++rear] = indices[front];
            front++;
        }
    }

    free(indices);
    return result;
}