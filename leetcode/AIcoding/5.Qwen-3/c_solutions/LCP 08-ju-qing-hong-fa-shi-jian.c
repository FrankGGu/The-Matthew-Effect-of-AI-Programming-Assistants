#include <stdio.h>
#include <stdlib.h>

int** getTriggerTime(int** group, int groupSize, int* m, int mSize, int** beforeMembers, int beforeMembersSize, int* beforeMembersColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * mSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * mSize);
    *returnSize = mSize;

    for (int i = 0; i < mSize; i++) {
        int* row = (int*)malloc(sizeof(int) * 3);
        result[i] = row;
        *returnColumnSizes[i] = 3;
    }

    for (int i = 0; i < mSize; i++) {
        int day = 0;
        int groupCount = 0;
        int memberCount = 0;

        while (groupCount < m[i] || memberCount < beforeMembers[i][0]) {
            if (groupCount < m[i]) {
                groupCount += group[day][0];
                memberCount += group[day][1];
                day++;
            } else {
                break;
            }
        }

        result[i][0] = day;
        result[i][1] = groupCount;
        result[i][2] = memberCount;
    }

    return result;
}