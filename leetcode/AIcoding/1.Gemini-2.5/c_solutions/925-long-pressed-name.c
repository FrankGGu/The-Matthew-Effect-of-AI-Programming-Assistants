#include <stdbool.h>
#include <string.h>

bool isLongPressedName(char * name, char * typed){
    int len_name = strlen(name);
    int len_typed = strlen(typed);

    int i = 0; // Pointer for the 'name' string
    int j = 0; // Pointer for the 'typed' string

    while (j < len_typed) {
        // Case 1: Characters match between name and typed
        if (i < len_name && name[i] == typed[j]) {
            i++;
            j++;
        } 
        // Case 2: Current typed character is a long-pressed duplicate of the previous typed character
        // This is only valid if we have already processed at least one character in typed (j > 0)
        // and the current typed character is the same as the one just before it.
        else if (j > 0 && typed[j] == typed[j-1]) {
            j++;
        } 
        // Case 3: Neither of the above conditions met.
        // This means typed[j] does not match name[i] (or name is exhausted),
        // AND typed[j] is not a valid long-pressed duplicate.
        // So, the typed string is invalid.
        else {
            return false;
        }
    }

    // After iterating through all characters in 'typed',
    // we must ensure that all characters in 'name' have been successfully matched.
    // If 'i' is less than 'len_name', it means some characters in 'name' were not found in 'typed'.
    return i == len_name;
}