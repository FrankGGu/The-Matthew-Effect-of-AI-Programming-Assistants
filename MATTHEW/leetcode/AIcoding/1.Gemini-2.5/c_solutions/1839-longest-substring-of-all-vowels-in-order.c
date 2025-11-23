#include <string.h>

int longestBeautifulSubstring(char * s) {
    int n = strlen(s);
    if (n < 5) {
        return 0;
    }

    int maxLength = 0;
    int i = 0;
    while (i < n) {
        if (s[i] != 'a') {
            i++;
            continue;
        }

        int j = i;
        int vowelsFound = 0;
        int currentLength = 0;
        char lastVowel = ' ';

        while (j < n) {
            char currentVowel = s[j];

            if (currentVowel == 'a') {
                if (lastVowel == ' ' || lastVowel == 'a') {
                    // Start or continue 'a' sequence
                } else {
                    // 'a' after a different vowel, break and restart
                    break;
                }
            } else if (currentVowel == 'e') {
                if (lastVowel == 'a' || lastVowel == 'e') {
                    // Continue 'e' sequence or transition from 'a'
                } else {
                    break;
                }
            } else if (currentVowel == 'i') {
                if (lastVowel == 'e' || lastVowel == 'i') {
                    // Continue 'i' sequence or transition from 'e'
                } else {
                    break;
                }
            } else if (currentVowel == 'o') {
                if (lastVowel == 'i' || lastVowel == 'o') {
                    // Continue 'o' sequence or transition from 'i'
                } else {
                    break;
                }
            } else if (currentVowel == 'u') {
                if (lastVowel == 'o' || lastVowel == 'u') {
                    // Continue 'u' sequence or transition from 'o'
                } else {
                    break;
                }
            } else {
                // Not a vowel, break
                break;
            }

            if (currentVowel != lastVowel) {
                if (currentVowel == 'a' && vowelsFound == 0) {
                    vowelsFound |= (1 << 0);
                } else if (currentVowel == 'e' && (vowelsFound & (1 << 0)) && !(vowelsFound & (1 << 1))) {
                    vowelsFound |= (1 << 1);
                } else if (currentVowel == 'i' && (vowelsFound & (1 << 1)) && !(vowelsFound & (1 << 2))) {
                    vowelsFound |= (1 << 2);
                } else if (currentVowel == 'o' && (vowelsFound & (1 << 2)) && !(vowelsFound & (1 << 3))) {
                    vowelsFound |= (1 << 3);
                } else if (currentVowel == 'u' && (vowelsFound & (1 << 3)) && !(vowelsFound & (1 << 4))) {
                    vowelsFound |= (1 << 4);
                } else {
                    // Invalid transition or vowel out of order
                    break;
                }
                lastVowel = currentVowel;
            }

            currentLength++;
            j++;
        }

        if (vowelsFound == ((1 << 5) - 1)) { // Check if all 5 vowels are present
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }

        // Move i to the start of the next potential substring
        // If j didn't move at all (i.e., s[i] was 'a' but next char broke it), i should increment
        // Otherwise, i should start from j (or j-1 if j moved past the end)
        if (j == i) { // No progress or a single 'a' that immediately broke
            i++;
        } else {
            i = j;
        }
    }

    return maxLength;
}