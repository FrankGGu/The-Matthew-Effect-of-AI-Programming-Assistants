#include <stdlib.h>
#include <string.h>

int word_mask_frequencies[1 << 26];

int calculate_mask(char* s) {
    int mask = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        mask |= (1 << (s[i] - 'a'));
    }
    return mask;
}

int* findNumOfValidWords(char** words, int wordsSize, char** puzzles, int puzzlesSize, int* returnSize) {
    // Clear the frequency array for each test case.
    // sizeof(word_mask_frequencies) calculates the total size in bytes of the array.
    memset(word_mask_frequencies, 0, sizeof(word_mask_frequencies));

    // Step 1: Preprocess all words to calculate their bitmasks and store their frequencies.
    for (int i = 0; i < wordsSize; i++) {
        int mask = calculate_mask(words[i]);
        word_mask_frequencies[mask]++;
    }

    // Allocate memory for the result array.
    int* result = (int*)malloc(puzzlesSize * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }
    *returnSize = puzzlesSize;

    // Step 2: For each puzzle, find the number of valid words.
    for (int i = 0; i < puzzlesSize; i++) {
        char* puzzle = puzzles[i];
        int puzzle_mask = calculate_mask(puzzle);

        // The first character of the puzzle must be present in a valid word.
        // We represent this as a single-bit mask.
        int first_char_bit = (1 << (puzzle[0] - 'a'));

        int current_valid_words_count = 0;

        // Iterate through all submasks of the puzzle_mask.
        // A submask 'sub_mask' represents a set of characters that are all present in the puzzle.
        // The loop `sub_mask = (sub_mask - 1) & puzzle_mask` efficiently iterates through all
        // non-empty submasks of `puzzle_mask` in decreasing order, down to 0.
        for (int sub_mask = puzzle_mask; sub_mask > 0; sub_mask = (sub_mask - 1) & puzzle_mask) {
            // Condition 1: The word (represented by sub_mask) must contain the first letter of the puzzle.
            if ((sub_mask & first_char_bit) != 0) {
                // Condition 2: All letters in the word must be present in the puzzle.
                // This is implicitly handled by iterating only through submasks of puzzle_mask.
                // If a word's mask matches 'sub_mask', and 'sub_mask' is a submask of 'puzzle_mask',
                // then all letters in the word are in the puzzle.
                current_valid_words_count += word_mask_frequencies[sub_mask];
            }
        }
        result[i] = current_valid_words_count;
    }

    return result;
}