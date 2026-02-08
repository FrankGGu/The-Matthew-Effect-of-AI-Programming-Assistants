#include <string.h>

long long maximizeNumberSubsequences(char * text, char * pattern){
    long long count0 = 0; // Counts occurrences of pattern[0] in text
    long long count1 = 0; // Counts occurrences of pattern[1] in text
    long long ans = 0;    // Counts subsequences of pattern[0]pattern[1] in the original text

    char p0 = pattern[0];
    char p1 = pattern[1];

    for (int i = 0; text[i] != '\0'; i++) {
        // If the current character is pattern[1], it can form subsequences
        // with all pattern[0] characters encountered so far.
        // This must be checked before potentially incrementing count0 if p0 == p1.
        if (text[i] == p1) {
            ans += count0;
            count1++; // Increment total count of pattern[1]
        }
        // If the current character is pattern[0], increment its count.
        if (text[i] == p0) {
            count0++; // Increment total count of pattern[0]
        }
    }

    // To maximize the number of subsequences, we have two options for inserting one character:
    // 1. Insert pattern[0]: The best place to insert pattern[0] is at the beginning of the string.
    //    This new pattern[0] can form a subsequence with every existing pattern[1] in the string.
    //    This adds 'count1' to the total subsequences.
    // 2. Insert pattern[1]: The best place to insert pattern[1] is at the end of the string.
    //    This new pattern[1] can form a subsequence with every existing pattern[0] in the string.
    //    This adds 'count0' to the total subsequences.

    // We choose the option that yields more additional subsequences.
    if (count0 > count1) {
        return ans + count0;
    } else {
        return ans + count1;
    }
}