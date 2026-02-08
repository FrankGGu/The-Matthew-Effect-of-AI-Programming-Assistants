#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct {
    char *word;
    int *count;
} Sticker;

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minStickers(char *target, char ** stickers, int stickersSize) {
    int targetLen = strlen(target);
    int stickerLen = 0;
    for (int i = 0; i < stickersSize; i++) {
        stickerLen = fmax(stickerLen, strlen(stickers[i]));
    }

    int targetCount[26] = {0};
    for (int i = 0; i < targetLen; i++) {
        targetCount[target[i] - 'a']++;
    }

    int result = INT_MAX;
    int used[26] = {0};

    int *stickerCounts = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCounts[i] = 0;
        for (int j = 0; j < strlen(stickers[i]); j++) {
            stickerCounts[i]++;
        }
    }

    qsort(stickerCounts, stickersSize, sizeof(int), compare);

    int *usedStickers = (int *)malloc(stickersSize * sizeof(int));
    int *currentCount = (int *)malloc(26 * sizeof(int));

    for (int i = 0; i < 26; i++) {
        currentCount[i] = 0;
    }

    for (int i = 0; i < stickersSize; i++) {
        usedStickers[i] = 0;
    }

    int *temp = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        temp[i] = 0;
    }

    int *remaining = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remaining[i] = targetCount[i];
    }

    int *stickerCountsCopy = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy[i] = stickerCounts[i];
    }

    int *stickerUsed = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerUsed[i] = 0;
    }

    int *remainingCopy = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remainingCopy[i] = remaining[i];
    }

    int *currentCountCopy = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        currentCountCopy[i] = currentCount[i];
    }

    int *tempCopy = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        tempCopy[i] = temp[i];
    }

    int *usedStickersCopy = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        usedStickersCopy[i] = usedStickers[i];
    }

    int *stickerCountsCopy2 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy2[i] = stickerCounts[i];
    }

    int *stickerUsedCopy = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerUsedCopy[i] = stickerUsed[i];
    }

    int *remainingCopy2 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remainingCopy2[i] = remaining[i];
    }

    int *currentCountCopy2 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        currentCountCopy2[i] = currentCount[i];
    }

    int *tempCopy2 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        tempCopy2[i] = temp[i];
    }

    int *usedStickersCopy2 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        usedStickersCopy2[i] = usedStickers[i];
    }

    int *stickerCountsCopy3 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy3[i] = stickerCounts[i];
    }

    int *stickerUsedCopy2 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerUsedCopy2[i] = stickerUsed[i];
    }

    int *remainingCopy3 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remainingCopy3[i] = remaining[i];
    }

    int *currentCountCopy3 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        currentCountCopy3[i] = currentCount[i];
    }

    int *tempCopy3 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        tempCopy3[i] = temp[i];
    }

    int *usedStickersCopy3 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        usedStickersCopy3[i] = usedStickers[i];
    }

    int *stickerCountsCopy4 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy4[i] = stickerCounts[i];
    }

    int *stickerUsedCopy3 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerUsedCopy3[i] = stickerUsed[i];
    }

    int *remainingCopy4 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remainingCopy4[i] = remaining[i];
    }

    int *currentCountCopy4 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        currentCountCopy4[i] = currentCount[i];
    }

    int *tempCopy4 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        tempCopy4[i] = temp[i];
    }

    int *usedStickersCopy4 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        usedStickersCopy4[i] = usedStickers[i];
    }

    int *stickerCountsCopy5 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy5[i] = stickerCounts[i];
    }

    int *stickerUsedCopy4 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerUsedCopy4[i] = stickerUsed[i];
    }

    int *remainingCopy5 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        remainingCopy5[i] = remaining[i];
    }

    int *currentCountCopy5 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        currentCountCopy5[i] = currentCount[i];
    }

    int *tempCopy5 = (int *)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) {
        tempCopy5[i] = temp[i];
    }

    int *usedStickersCopy5 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        usedStickersCopy5[i] = usedStickers[i];
    }

    int *stickerCountsCopy6 = (int *)malloc(stickersSize * sizeof(int));
    for (int i = 0; i < stickersSize; i++) {
        stickerCountsCopy6[i] = stickerCounts