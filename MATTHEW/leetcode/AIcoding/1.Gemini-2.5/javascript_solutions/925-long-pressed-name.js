var isLongPressedName = function(name, typed) {
    let i = 0; // Pointer for name
    let j = 0; // Pointer for typed

    while (j < typed.length) {
        // Case 1: Characters match - advance both pointers
        if (i < name.length && name[i] === typed[j]) {
            i++;
            j++;
        }
        // Case 2: Character in typed is a long press of the previous character in typed
        // This is valid only if j > 0 (to have a previous character)
        else if (j > 0 && typed[j] === typed[j-1]) {
            j++;
        }
        // Case 3: Mismatch and not a valid long press - return false
        else {
            return false;
        }
    }

    // After iterating through typed, all characters in name must have been matched.
    // If i has not reached the end of name, it means name was not fully typed.
    return i === name.length;
};