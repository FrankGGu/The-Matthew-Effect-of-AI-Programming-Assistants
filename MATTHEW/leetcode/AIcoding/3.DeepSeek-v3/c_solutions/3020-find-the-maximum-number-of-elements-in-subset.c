#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

int maximumLength(int* nums, int numsSize) {
    long long* arr = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
    }
    qsort(arr, numsSize, sizeof(long long), cmp);

    int* count = (int*)calloc(numsSize, sizeof(int));
    int idx = 0;
    count[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        if (arr[i] == arr[idx]) {
            count[idx]++;
        } else {
            idx++;
            arr[idx] = arr[i];
            count[idx] = 1;
        }
    }
    int n = idx + 1;

    int max_len = 1;
    for (int i = 0; i < n; i++) {
        long long val = arr[i];
        int cnt = count[i];
        if (val == 1) {
            max_len = cnt % 2 ? cnt : cnt - 1;
            continue;
        }
        if (cnt >= 2) {
            int len = 2;
            long long curr = val * val;
            while (1) {
                int left = 0, right = n - 1;
                int found = 0;
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if (arr[mid] == curr) {
                        if (count[mid] >= 2) {
                            len += 2;
                            curr = curr * curr;
                            found = 1;
                        } else {
                            found = -1;
                        }
                        break;
                    } else if (arr[mid] < curr) {
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }
                if (!found) break;
                if (found == -1) {
                    len++;
                    break;
                }
            }
            if (len % 2 == 0) len--;
            if (len > max_len) max_len = len;
        }
    }
    free(arr);
    free(count);
    return max_len;
}