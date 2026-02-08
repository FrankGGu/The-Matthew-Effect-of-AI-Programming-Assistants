#include <stdbool.h>

bool isLongPressedName(char * name, char * typed) {
    int i = 0; // Pointer for 'name' string
    int j = 0; // Pointer for 'typed' string

    // Iterate through the 'typed' string
    while (typed[j] != '\0') {
        // Case 1: Current characters in 'name' and 'typed' match
        // and we haven't exhausted the 'name' string yet.
        if (name[i] != '\0' && name[i] == typed[j]) {
            i++; // Advance 'name' pointer
            j++; // Advance 'typed' pointer
        }
        // Case 2: Current 'typed' character is a long-press of the *previous* 'typed' character.
        // This means typed[j] matches typed[j-1], and we must have already processed at least one character in 'typed' (j > 0).
        else if (j > 0 && typed[j] == typed[j-1]) {
            j++; // Only advance 'typed' pointer, as this is a long-pressed character
        }
        // Case 3: Mismatch, and it's not a long-press of the previous character.
        // This indicates that 'typed' cannot be formed from 'name'.
        else {
            return false;
        }
    }

    // After iterating through the entire 'typed' string,
    // all characters in 'name' must have been successfully matched.
    // If name[i] is not '\0', it means there are remaining characters in 'name'
    // that were not found in 'typed', so it's not a valid long-pressed name.
    return name[i] == '\0';
}