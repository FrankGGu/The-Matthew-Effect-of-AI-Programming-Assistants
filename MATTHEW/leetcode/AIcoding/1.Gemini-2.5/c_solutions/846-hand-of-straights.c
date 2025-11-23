#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memset, if needed

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

typedef struct {
    int val;
    int count;
} FreqEntry;

bool isNStraightHand(int* hand, int handSize, int groupSize) {
    if (handSize % groupSize != 0) {
        return false;
    }
    if (handSize == 0) { // Empty hand, always true if groupSize is non-zero (problem constraints say groupSize >= 1)
        return true;
    }
    if (groupSize == 1) { // Each card is a group of size 1, always true
        return true;
    }

    qsort(hand, handSize, sizeof(int), compare);

    // Build a frequency map as a sorted array of FreqEntry structs
    FreqEntry* freqMap = (FreqEntry*)malloc(sizeof(FreqEntry) * handSize);
    if (!freqMap) {
        return false; // Handle allocation failure
    }

    int uniqueCount = 0;
    if (handSize > 0) {
        freqMap[uniqueCount].val = hand[0];
        freqMap[uniqueCount].count = 1;
        uniqueCount++;

        for (int i = 1; i < handSize; i++) {
            if (hand[i] == hand[i-1]) {
                freqMap[uniqueCount-1].count++;
            } else {
                freqMap[uniqueCount].val = hand[i];
                freqMap[uniqueCount].count = 1;
                uniqueCount++;
            }
        }
    }

    // Iterate through the freqMap to form groups
    for (int i = 0; i < uniqueCount; i++) {
        // If this card entry has been fully used, skip it.
        // Otherwise, freqMap[i].val is the smallest available card to start a new group.
        if (freqMap[i].count == 0) {
            continue;
        }

        int currentGroupStartVal = freqMap[i].val;
        int currentFreqMapIdx = i; // Pointer to search for consecutive cards in freqMap

        // Try to form a group of 'groupSize' consecutive cards
        for (int k = 0; k < groupSize; k++) {
            int targetVal = currentGroupStartVal + k;

            // Advance currentFreqMapIdx to find targetVal
            // This loop ensures currentFreqMapIdx points to the correct entry for targetVal
            // or goes past it if targetVal is not found.
            while (currentFreqMapIdx < uniqueCount && freqMap[currentFreqMapIdx].val < targetVal) {
                currentFreqMapIdx++;
            }

            // Check if targetVal is found and available
            if (currentFreqMapIdx == uniqueCount || freqMap[currentFreqMapIdx].val != targetVal || freqMap[currentFreqMapIdx].count == 0) {
                free(freqMap);
                return false; // Required consecutive card not found or not available
            }

            // Decrement count for the found card
            freqMap[currentFreqMapIdx].count--;

            // For the next consecutive card (targetVal + 1), start searching from currentFreqMapIdx + 1
            // This is implicitly handled by the outer `while` loop in the next iteration of `k`.
            // The `currentFreqMapIdx` will be at least the index of the current `targetVal`.
            // For the next `k`, `targetVal` will be `targetVal + 1`, so `currentFreqMapIdx` will be advanced further.
        }
    }

    free(freqMap);
    return true;
}