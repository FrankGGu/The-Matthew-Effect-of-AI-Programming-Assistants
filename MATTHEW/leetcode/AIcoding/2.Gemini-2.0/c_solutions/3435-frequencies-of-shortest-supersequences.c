#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 205
#define INF 1e9

int shortestSupersequence(int* nums1, int nums1Size, int* nums2, int nums2Size, int* ans, int* returnSize){
    int n1 = nums1Size;
    int n2 = nums2Size;
    int pos[MAXN][MAXN];
    for (int i = 0; i < MAXN; i++) {
        for (int j = 0; j < MAXN; j++) {
            pos[i][j] = INF;
        }
    }

    for (int i = 0; i < n2; i++) {
        int last = INF;
        for (int j = n1 - 1; j >= 0; j--) {
            if (nums1[j] == nums2[i]) {
                last = j;
            }
            pos[i][j] = last;
        }
    }

    int len = INF;
    int cnt = 0;

    for (int i = 0; i < n1; i++) {
        if (nums1[i] == nums2[0]) {
            int cur = i;
            int j = 1;
            while (j < n2) {
                cur = pos[j][cur + 1];
                if (cur == INF) break;
                j++;
            }

            if (j == n2) {
                if (cur - i + 1 < len) {
                    len = cur - i + 1;
                    cnt = 1;
                } else if (cur - i + 1 == len) {
                    cnt++;
                }
            }
        }
    }

    *returnSize = 2;
    ans[0] = len;
    ans[1] = cnt;

    return 0;
}