#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumLevels(int* levels, int levelsSize, int r) {
    int l = 0, h = levelsSize;
    int ans = levelsSize;
    while (l <= h) {
        int mid = l + (h - l) / 2;
        long long points = r;
        int flag = 1;
        for (int i = 0; i < levelsSize; i++) {
            if (levels[i] > points) {
                if (mid > 0) {
                    mid--;
                    points *= 2;
                    if (levels[i] > points) {
                        flag = 0;
                        break;
                    }
                } else {
                    flag = 0;
                    break;
                }
            }
            points += levels[i] - (int) (levels[i] / 10.0);
        }
        if (flag) {
            ans = mid;
            h = mid - 1;
        } else {
            l = mid + 1;
        }
    }
    return ans;
}