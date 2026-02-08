class Solution {
public:
    bool isLongPressedName(std::string name, std::string typed) {
        int i = 0; // Pointer for the 'name' string
        int j = 0; // Pointer for the 'typed' string

        while (j < typed.length()) {
            if (i < name.length() && name[i] == typed[j]) {
                // If the current characters in both strings match, advance both pointers.
                i++;
                j++;
            } else if (j > 0 && typed[j] == typed[j-1]) {
                // If the current character in 'typed' is a repetition of the previous character in 'typed',
                // it's considered a "long press" and is allowed. Advance only the 'typed' pointer.
                j++;
            } else {
                // If neither of the above conditions is met, it means:
                // 1. The character in 'typed' does not match the expected character in 'name'.
                // 2. It's not a valid long press (either it's the first character of 'typed',
                //    or it's different from the previous character in 'typed').
                // In this case, 'typed' cannot be formed from 'name' with long presses.
                return false;
            }
        }

        // After iterating through 'typed', check if all characters of 'name' have been successfully matched.
        // If 'i' has reached the end of 'name', it means 'name' was fully typed.
        return i == name.length();
    }
};