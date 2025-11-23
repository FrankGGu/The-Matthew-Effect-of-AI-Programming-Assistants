#include <stdlib.h> // For malloc, qsort

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int find_first_ge(int* arr, int size, long long target) {
    int low = 0;
    int high = size - 1;
    int ans_idx = size; // Initialize to size, indicating no element found yet

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans_idx = mid; // This element could be the answer, try to find an earlier one
            high = mid - 1;
        } else {
            low = mid + 1; // arr[mid] is too small, look in the right half
        }
    }
    return ans_idx;
}

int* successfulPairs(int* spells, int spellsSize, int* potions, int potionsSize, long long success, int* returnSize) {
    // Allocate memory for the result array
    int* ans = (int*)malloc(spellsSize * sizeof(int));
    if (ans == NULL) {
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }

    // Sort the potions array to enable binary search
    qsort(potions, potionsSize, sizeof(int), compareInts);

    // Iterate through each spell
    for (int i = 0; i < spellsSize; i++) {
        long long current_spell = spells[i];

        // Calculate the minimum required potion value for the current spell
        // We need spell * potion >= success, so potion >= success / spell.
        // Using integer ceiling division: ceil(A/B) = (A + B - 1) / B for positive A, B.
        long long min_required_potion;
        // Constraints state spells[i] >= 1, so current_spell will never be zero.
        min_required_potion = (success + current_spell - 1) / current_spell;

        // Find the index of the first potion in the sorted 'potions' array
        // that meets or exceeds 'min_required_potion'.
        int idx = find_first_ge(potions, potionsSize, min_required_potion);

        // The number of successful pairs for the current spell is the count of
        // potions from 'idx' to the end of the 'potions' array.
        ans[i] = potionsSize - idx;
    }

    *returnSize = spellsSize;
    return ans;
}