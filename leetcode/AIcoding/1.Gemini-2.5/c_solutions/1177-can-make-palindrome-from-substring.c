#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For strlen

bool* canMakePaliQueries(char * s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int s_len = strlen(s);

    // prefix_parity[i] stores a bitmask representing the parity of character counts
    // for the substring s[0...i-1].
    // The j-th bit is set if character 'a' + j appears an odd number of times.
    int* prefix_parity = (int*) malloc((s_len + 1) * sizeof(int));

    prefix_parity[0] = 0; // Empty prefix has all even counts
    for (int i = 0; i < s_len; ++i) {
        // Toggle the bit corresponding to the current character
        prefix_parity[i+1] = prefix_parity[i] ^ (1 << (s[i] - 'a'));
    }

    bool* result = (bool*) malloc(queriesSize * sizeof(bool));

    for (int i = 0; i < queriesSize; ++i) {
        int left = queries[i][0];
        int right = queries[i][1];
        int k = queries[i][2];

        // The parity mask for the substring s[left...right] is obtained by XORing
        // prefix_parity[right+1] (for s[0...right]) and prefix_parity[left] (for s[0...left-1]).
        // This effectively cancels out characters in the common prefix s[0...left-1],
        // leaving only the parities for s[left...right].
        int current_parity_mask = prefix_parity[right + 1] ^ prefix_parity[left];

        // Count the number of set bits in the mask. This gives the number of characters
        // that appear an odd number of times in the substring s[left...right].
        int odd_counts = __builtin_popcount(current_parity_mask);

        // A string can be rearranged into a palindrome if at most one character
        // appears an odd number of times.
        // If there are 'odd_counts' characters with odd frequencies, we need to change
        // (odd_counts / 2) characters to make pairs that can be rearranged evenly.
        // For example, if we have 'a', 'b', 'c' (3 odd counts), changing 'b' to 'a'
        // makes it 'a', 'a', 'c'. Now 'a' is even, 'c' is odd. One change resolved two odd counts.
        result[i] = (odd_counts / 2) <= k;
    }

    free(prefix_parity);
    *returnSize = queriesSize;
    return result;
}