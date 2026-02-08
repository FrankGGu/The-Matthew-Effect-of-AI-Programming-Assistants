#include <stdlib.h> // For malloc, qsort

typedef struct {
    int count;
    char ch;
} CharInfo;

int compareCharInfo(const void *a, const void *b) {
    return ((CharInfo*)b)->count - ((CharInfo*)a)->count;
}

char* longestDiverseString(int a, int b, int c) {
    // Allocate memory for the result string. Max length is 300 (100 'a's, 100 'b's, 100 'c's) + null terminator.
    char* result = (char*)malloc(sizeof(char) * 301);

    int len = 0; // Current length of the result string

    // Initialize CharInfo array for 'a', 'b', 'c'
    CharInfo chars[3];
    chars[0] = (CharInfo){a, 'a'};
    chars[1] = (CharInfo){b, 'b'};
    chars[2] = (CharInfo){c, 'c'};

    // Main loop to build the string
    while (1) { // Use 1 for true
        // Sort characters by their remaining counts in descending order
        qsort(chars, 3, sizeof(CharInfo), compareCharInfo);

        int appended_this_iteration = 0; // Flag to check if any character was appended (0 for false, 1 for true)

        // Try to append the most frequent character (chars[0])
        if (chars[0].count > 0) {
            // Check if appending chars[0] would create 'xxx' (e.g., 'aaa')
            if (len >= 2 && result[len-1] == chars[0].ch && result[len-2] == chars[0].ch) {
                // Cannot append chars[0], try the second most frequent character (chars[1])
                if (chars[1].count > 0) {
                    result[len++] = chars[1].ch;
                    chars[1].count--;
                    appended_this_iteration = 1;
                }
            } else {
                // Can append chars[0]
                result[len++] = chars[0].ch;
                chars[0].count--;
                appended_this_iteration = 1;

                // Try to append chars[0] again if it's still significantly more abundant
                // and doesn't violate the 'xxx' rule
                // The condition chars[0].count >= chars[1].count ensures we prioritize
                // using the most frequent character twice if possible, as long as it doesn't
                // make the second most frequent character become more frequent.
                if (chars[0].count > 0 && chars[0].count >= chars[1].count &&
                    !(len >= 2 && result[len-1] == chars[0].ch && result[len-2] == chars[0].ch)) {
                    result[len++] = chars[0].ch;
                    chars[0].count--;
                }
            }
        }

        // If no character was appended in this iteration, we cannot extend the string further
        if (!appended_this_iteration) {
            break;
        }
    }

    // Null-terminate the result string
    result[len] = '\0';
    return result;
}