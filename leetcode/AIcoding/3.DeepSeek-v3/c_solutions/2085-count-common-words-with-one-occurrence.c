/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int countWords(char** words1, int words1Size, char** words2, int words2Size) {
    int count = 0;

    for (int i = 0; i < words1Size; i++) {
        int freq1 = 0;
        int freq2 = 0;

        for (int j = 0; j < words1Size; j++) {
            if (strcmp(words1[i], words1[j]) == 0) {
                freq1++;
            }
        }

        if (freq1 != 1) continue;

        for (int j = 0; j < words2Size; j++) {
            if (strcmp(words1[i], words2[j]) == 0) {
                freq2++;
            }
        }

        if (freq2 == 1) {
            count++;
        }
    }

    return count;
}