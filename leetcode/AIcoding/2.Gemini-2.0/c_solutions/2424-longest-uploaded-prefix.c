#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestUploadedPrefix(int n, int* uploads, int uploadsSize) {
    bool uploaded[n + 1];
    for (int i = 0; i <= n; i++) {
        uploaded[i] = false;
    }

    int prefix = 0;
    for (int i = 0; i < uploadsSize; i++) {
        uploaded[uploads[i]] = true;

        if (uploads[i] == prefix + 1) {
            while (prefix + 1 <= n && uploaded[prefix + 1]) {
                prefix++;
            }
        }
    }

    return prefix;
}