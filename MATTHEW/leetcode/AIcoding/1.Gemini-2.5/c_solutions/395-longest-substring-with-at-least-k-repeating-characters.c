#include <string.h> // For strlen
#include <math.h>   // For fmax

static int longestSubstringRecursive(char* s, int start, int end, int k) {
    // Base case 1: If the substring length is less than k, it cannot satisfy the condition.
    if (end - start < k) {
        return 0;
    }

    // Count character frequencies in the current substring s[start...end-1]
    int freq[26] = {0};
    for (int i = start; i < end; i++) {
        freq[s[i] - 'a']++;
    }

    // Find a character that appears less than k times in the current substring.
    // This character cannot be part of any valid substring within s[start...end-1].
    int splitCharIdx = -1;
    for (int i = 0; i < 26; i++) {
        // If the character exists in the current substring and its frequency is less than k
        if (freq[i] > 0 && freq[i] < k) {
            splitCharIdx = i;
            break; // Found a character to split by
        }
    }

    // Base case 2: If all characters appear at least k times,
    // then the current substring itself is a valid solution.
    if (splitCharIdx == -1) {
        return end - start;
    }

    // Recursive step: Split the string by the 'bad' character
    int maxLen = 0;
    int currentSegmentStart = start;
    for (int i = start; i < end; i++) {
        // If we encounter the split character, process the segment before it
        if (s[i] == (char)('a' + splitCharIdx)) {
            maxLen = fmax(maxLen, longestSubstringRecursive(s, currentSegmentStart, i, k));
            currentSegmentStart = i + 1; // Start of the next segment
        }
    }
    // Process the last segment after the last split character or if no split character was found in the loop
    maxLen = fmax(maxLen, longestSubstringRecursive(s, currentSegmentStart, end, k));

    return maxLen;
}

int longestSubstring(char * s, int k){
    // Problem constraints state s.length >= 1 and k >= 1, so no need for null/empty string checks.
    return longestSubstringRecursive(s, 0, strlen(s), k);
}