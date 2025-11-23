#include <string.h>

int minimumLength(char * s){
    int n = strlen(s);
    int left = 0;
    int right = n - 1;

    while (left < right && s[left] == s[right]) {
        char char_to_remove = s[left];

        // Remove all occurrences of char_to_remove from the left prefix
        while (left <= right && s[left] == char_to_remove) {
            left++;
        }

        // Remove all occurrences of char_to_remove from the right suffix
        while (left <= right && s[right] == char_to_remove) {
            right--;
        }
    }

    // If left pointer has crossed right pointer, it means the string is empty
    // or all characters were removed.
    // Otherwise, the remaining length is right - left + 1.
    if (left > right) {
        return 0;
    } else {
        return right - left + 1;
    }
}