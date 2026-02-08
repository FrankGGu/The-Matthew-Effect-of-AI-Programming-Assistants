#include <string.h>

int minimumAdditions(char * word) {
    int additions = 0;
    int state = 0; // 0 for expecting 'a', 1 for expecting 'b', 2 for expecting 'c'

    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        int char_val = word[i] - 'a';

        if (char_val == state) {
            // The current character matches the one we expected.
            // Move to the next expected character in the sequence.
            state = (state + 1) % 3;
        } else if (char_val == (state + 1) % 3) {
            // The current character is the one AFTER the one we expected.
            // This means we missed the expected character (e.g., expected 'a', got 'b').
            // Add 1 for the missing character.
            additions++;
            // Now, conceptually, we have matched the expected character (virtually added)
            // and the current character (from input). So we are now expecting
            // the character after the current one.
            state = (char_val + 1) % 3;
        } else { // char_val == (state + 2) % 3
            // The current character is TWO AFTER the one we expected.
            // This means we missed two characters (e.g., expected 'a', got 'c').
            // Add 2 for the two missing characters.
            additions += 2;
            // Conceptually, we have matched the two expected characters (virtually added)
            // and the current character (from input). So we are now expecting
            // the character after the current one.
            state = (char_val + 1) % 3;
        }
    }

    // After processing all characters, if the last sequence is not complete,
    // we need to add the remaining characters.
    // If state is 0, the last 'abc' sequence was completed. Add 0.
    // If state is 1, we have 'a', need 'b' and 'c'. Add 2.
    // If state is 2, we have 'ab', need 'c'. Add 1.
    additions += (3 - state) % 3;

    return additions;
}