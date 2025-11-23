#include <stdbool.h>
#include <stdlib.h>

bool canTransform(char *start, char *end) {
    int n = strlen(start);
    int countXStart = 0, countXEnd = 0;

    for (int i = 0; i < n; i++) {
        if (start[i] == 'X') countXStart++;
        if (end[i] == 'X') countXEnd++;
        if (start[i] != end[i] && start[i] != 'X' && end[i] != 'X') return false;
    }

    if (countXStart != countXEnd) return false;

    int j = 0;
    for (int i = 0; i < n; i++) {
        if (start[i] != 'X') {
            while (j < n && (end[j] != start[i] || end[j] == 'X')) j++;
            if (j == n) return false;
            if (start[i] == 'L' && j < i) return false;
            if (start[i] == 'R' && j > i) return false;
            j++;
        }
    }

    return true;
}