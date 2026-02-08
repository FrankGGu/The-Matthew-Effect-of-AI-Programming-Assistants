#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char nextGreatestLetter(char* letters, int lettersSize, char target) {
    int left = 0, right = lettersSize - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (letters[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return letters[left % lettersSize];
}