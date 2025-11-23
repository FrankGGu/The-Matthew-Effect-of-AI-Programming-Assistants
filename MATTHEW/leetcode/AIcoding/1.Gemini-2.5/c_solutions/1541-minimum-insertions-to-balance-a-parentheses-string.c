#include <string.h>

int minInsertions(char * s){
    int open_needed = 0;
    int insertions = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            // If we currently need an odd number of ')'s, it means the previous '('
            // was matched with only one ')'. We need to insert another ')' to complete that pair.
            if (open_needed % 2 == 1) {
                insertions++;
                open_needed--; // Now open_needed is even, meaning all existing '(' are waiting for '))'
            }
            open_needed += 2; // This new '(' needs two ')'s.
        } else { // s[i] == ')'
            open_needed--; // This ')' consumes one ')' from the open_needed count.

            // If open_needed becomes negative, it means we encountered a ')' without a preceding '('.
            // We need to insert an '('.
            if (open_needed < 0) {
                insertions++; // Insert '('
                open_needed += 2; // This inserted '(' needs two ')'s. So open_needed becomes 1 after consuming the current ')'.
            }
        }
    }

    // Any remaining open_needed means we need to insert that many ')'s.
    insertions += open_needed;

    return insertions;
}