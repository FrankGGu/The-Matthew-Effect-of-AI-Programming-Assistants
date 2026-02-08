#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumSetSize(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int s1[50001] = {0};
    int s2[50001] = {0};
    int common[50001] = {0};
    int c1 = 0, c2 = 0, cc = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (s1[nums1[i]] == 0) {
            s1[nums1[i]] = 1;
            c1++;
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (s2[nums2[i]] == 0) {
            s2[nums2[i]] = 1;
            c2++;
        }
    }

    for (int i = 0; i < 50001; i++) {
        if (s1[i] && s2[i]) {
            common[i] = 1;
            cc++;
            c1--;
            c2--;
        }
    }

    int n = nums1Size + nums2Size;
    int half = n / 2;

    int ans = 0;
    ans += (c1 <= half) ? c1 : half;
    ans += (c2 <= half) ? c2 : half;
    ans += cc;

    if (ans > half * 2) {
        ans = half * 2;
    }

    return ans;
}