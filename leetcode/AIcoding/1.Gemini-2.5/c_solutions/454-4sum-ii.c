#include <string.h>

#define MAP_SIZE 400001
#define OFFSET 200000

static int freq_map[MAP_SIZE];

int fourSumCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* nums4, int nums4Size) {
    memset(freq_map, 0, sizeof(freq_map));

    for (int i = 0; i < nums1Size; ++i) {
        for (int j = 0; j < nums2Size; ++j) {
            freq_map[nums1[i] + nums2[j] + OFFSET]++;
        }
    }

    int count = 0;
    for (int k = 0; k < nums3Size; ++k) {
        for (int l = 0; l < nums4Size; ++l) {
            int target_sum = -(nums3[k] + nums4[l]);
            count += freq_map[target_sum + OFFSET];
        }
    }

    return count;
}