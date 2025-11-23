#include <string>

class Solution {
public:
    bool isLongPressedName(std::string name, std::string typed) {
        int i = 0; // Pointer for name string
        int j = 0; // Pointer for typed string

        while (j < typed.length()) {
            // If characters match in both strings, advance both pointers
            if (i < name.length() && name[i] == typed[j]) {
                i++;
                j++;
            }
            // If the current character in typed is a long press of the previous character in typed,
            // advance only the typed pointer
            else if (j > 0 && typed[j] == typed[j-1]) {
                j++;
            }
            // If neither of the above conditions is met, it's a mismatch or an extra character
            // that is not a long press, so return false
            else {
                return false;
            }
        }

        // After iterating through the typed string, all characters in the name string
        // must have been matched. If not, it means name was not fully typed.
        return i == name.length();
    }
};