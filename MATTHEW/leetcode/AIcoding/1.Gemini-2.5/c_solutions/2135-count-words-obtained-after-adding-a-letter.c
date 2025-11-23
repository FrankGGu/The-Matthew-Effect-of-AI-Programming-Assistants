#include <string.h>
#include <stdbool.h>

bool startWordMasksPresent[1 << 26];

int countWords(char **startWords, int startWordsSize, char **targetWords, int targetWordsSize) {
    memset(startWordMasksPresent, 0, sizeof(startWordMasksPresent));

    for (int i = 0; i < startWordsSize; i++) {
        char *s = startWords[i];
        int mask = 0;
        for (int j = 0; s[j] != '\0'; j++) {
            mask |= (1 << (s[j] - 'a'));
        }
        startWordMasksPresent[mask] = true;
    }

    int count = 0;

    for (int i = 0; i < targetWordsSize; i++) {
        char *t = targetWords[i];
        int targetMask = 0;
        for (int j = 0; t[j] != '\0'; j++) {
            targetMask |= (1 << (t[j] - 'a'));
        }

        bool found = false;
        for (int j = 0; t[j] != '\0'; j++) {
            int prevMask = targetMask ^ (1 << (t[j] - 'a'));

            if (startWordMasksPresent[prevMask]) {
                found = true;
                break;
            }
        }

        if (found) {
            count++;
        }
    }

    return count;
}