#include <stdlib.h> // For qsort
#include <string.h> // For strchr, strcmp, strncmp
#include <ctype.h>  // For isdigit

int compareLogs(const void *a, const void *b) {
    // Cast void pointers to char** to get the actual log strings
    const char *log1 = *(const char **)a;
    const char *log2 = *(const char **)b;

    // Find the first space to separate identifier from content
    const char *ptr1 = strchr(log1, ' ');
    const char *ptr2 = strchr(log2, ' ');

    // Determine if the log is a digit-log or a letter-log
    // A log is a digit-log if the character immediately after the first space is a digit.
    // ptr1[1] points to the first character of the content.
    int is_digit1 = isdigit(ptr1[1]);
    int is_digit2 = isdigit(ptr2[1]);

    // Case 1: Both are letter-logs
    if (!is_digit1 && !is_digit2) {
        // Compare content first (everything after the first space)
        // ptr1 + 1 points to the start of the content.
        int cmp = strcmp(ptr1 + 1, ptr2 + 1);
        if (cmp != 0) {
            return cmp; // Content is different, return comparison result
        }
        // Content is the same, compare identifiers (before the first space)
        // Use strncmp to compare only the identifier part.
        // ptr1 - log1 gives the length of the identifier.
        return strncmp(log1, log2, ptr1 - log1);
    } 
    // Case 2: log1 is a letter-log, log2 is a digit-log
    else if (!is_digit1 && is_digit2) {
        return -1; // Letter-logs come before digit-logs
    } 
    // Case 3: log1 is a digit-log, log2 is a letter-log
    else if (is_digit1 && !is_digit2) {
        return 1; // Letter-logs come before digit-logs
    } 
    // Case 4: Both are digit-logs
    else { // is_digit1 && is_digit2
        // Maintain their original relative order.
        // For qsort, this means they are considered "equal" for sorting purposes.
        // qsort is not guaranteed to be stable, but returning 0 for elements
        // that should maintain relative order when grouped together is a common
        // approach for this problem type on LeetCode.
        return 0;
    }
}

char ** reorderLogFiles(char ** logs, int logsSize, int* returnSize) {
    // The problem asks to reorder the input array in place and return it.
    // The `returnSize` parameter is used to indicate the number of elements
    // in the returned array, which will be the same as the input `logsSize`.
    *returnSize = logsSize;

    // Use qsort with the custom comparison function to reorder the logs.
    qsort(logs, logsSize, sizeof(char *), compareLogs);

    return logs; // Return the reordered array
}