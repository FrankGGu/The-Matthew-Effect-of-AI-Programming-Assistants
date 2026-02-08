#include <string.h>
#include <stdlib.h>

int repeatedStringMatch(char * a, char * b){
    int len_a = strlen(a);
    int len_b = strlen(b);

    // Calculate the minimum number of times 'a' needs to be repeated
    // so that the repeated string is at least as long as 'b'.
    // This is equivalent to ceil(len_b / len_a).
    int count = (len_b + len_a - 1) / len_a;

    // Allocate memory for the temporary string.
    // We need to check 'count' repetitions and 'count + 1' repetitions.
    // The maximum length of the string to build will be (count + 1) * len_a.
    // Add 1 for the null terminator.
    // The maximum value for (count + 1) * len_a is approximately len_b + 2*len_a.
    // For max lengths (10^4 for both), this is about 10^4 + 2*10^4 = 30000.
    char *temp_s = (char *)malloc(sizeof(char) * ((long long)(count + 1) * len_a + 1));
    if (temp_s == NULL) {
        return -1; // Memory allocation failed
    }

    // Efficiently build the string by repeatedly copying 'a'.
    char *current_pos = temp_s;
    for (int i = 0; i < count; i++) {
        memcpy(current_pos, a, len_a);
        current_pos += len_a;
    }
    *current_pos = '\0'; // Null-terminate the string

    // Check if 'b' is a substring of the current repeated string ('count' times).
    if (strstr(temp_s, b) != NULL) {
        free(temp_s);
        return count;
    }

    // If not found, append 'a' one more time.
    // This covers cases where 'b' spans across the boundary of two 'a' strings,
    // requiring one more 'a' than initially calculated.
    memcpy(current_pos, a, len_a);
    current_pos += len_a;
    *current_pos = '\0'; // Null-terminate the extended string
    count++; // Increment the repetition count

    // Check again if 'b' is a substring of the extended repeated string ('count + 1' times).
    if (strstr(temp_s, b) != NULL) {
        free(temp_s);
        return count;
    }

    // If 'b' is still not found after 'count + 1' repetitions, it's impossible.
    free(temp_s);
    return -1;
}