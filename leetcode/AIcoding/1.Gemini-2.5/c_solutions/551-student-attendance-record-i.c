#include <stdbool.h>
#include <string.h>

bool checkRecord(char *s) {
    int absentCount = 0;
    int lateStreak = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == 'A') {
            absentCount++;
            lateStreak = 0; 
        } else if (s[i] == 'L') {
            lateStreak++;
        } else { // s[i] == 'P'
            lateStreak = 0;
        }

        if (absentCount >= 2) {
            return false;
        }
        if (lateStreak >= 3) {
            return false;
        }
    }

    return true;
}