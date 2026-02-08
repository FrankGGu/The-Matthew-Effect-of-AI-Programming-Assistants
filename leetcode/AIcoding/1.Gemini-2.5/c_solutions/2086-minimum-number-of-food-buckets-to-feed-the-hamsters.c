#include <string.h> // Required for strlen and strcpy

int minimumBuckets(char *hamsters) {
    int n = strlen(hamsters);
    int buckets = 0;

    // Create a mutable copy of the string to mark placed buckets.
    // 'B' will represent a placed food bucket.
    char s[n + 1]; 
    strcpy(s, hamsters);

    for (int i = 0; i < n; ++i) {
        if (s[i] == 'H') { // Found a hamster
            // Rule 1: Check if this hamster is already fed by a bucket to its left.
            // This happens if a bucket was placed at s[i-1] for s[i-2] or s[i].
            if (i > 0 && s[i-1] == 'B') {
                continue; // Hamster is fed, move to the next character.
            }

            // Rule 2: Try to place a bucket to its right (most optimal choice).
            // Placing a bucket at s[i+1] feeds s[i] and potentially s[i+2].
            if (i + 1 < n && s[i+1] == '.') {
                s[i+1] = 'B'; // Place the bucket.
                buckets++;
                // Skip the bucket itself (s[i+1]) and the potential hamster it feeds (s[i+2]).
                // The loop's ++i will increment i by 1, so we need to increment i by 1 more
                // to effectively skip s[i+1] and s[i+2].
                i += 1; 
            }
            // Rule 3: If placing to the right is not possible, try to place a bucket to its left (fallback).
            // This bucket would feed s[i] and potentially s[i-2].
            else if (i - 1 >= 0 && s[i-1] == '.') {
                s[i-1] = 'B'; // Place the bucket.
                buckets++;
                // No need to adjust 'i' further, as s[i] is fed and s[i-1] was already processed
                // (or will be skipped if it was a hamster). The loop's ++i handles moving to the next position.
            }
            // Rule 4: If neither placing to the right nor left is possible, this hamster cannot be fed.
            else {
                return -1;
            }
        }
    }
    return buckets;
}