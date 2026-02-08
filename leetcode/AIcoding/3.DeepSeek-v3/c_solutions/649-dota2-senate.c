#include <stdlib.h>
#include <string.h>

char* predictPartyVictory(char* senate) {
    int n = strlen(senate);
    int* radiant = (int*)malloc(n * sizeof(int));
    int* dire = (int*)malloc(n * sizeof(int));
    int r_size = 0, d_size = 0;

    for (int i = 0; i < n; i++) {
        if (senate[i] == 'R') {
            radiant[r_size++] = i;
        } else {
            dire[d_size++] = i;
        }
    }

    while (r_size > 0 && d_size > 0) {
        if (radiant[0] < dire[0]) {
            radiant[r_size++] = radiant[0] + n;
        } else {
            dire[d_size++] = dire[0] + n;
        }

        for (int i = 0; i < r_size - 1; i++) {
            radiant[i] = radiant[i + 1];
        }
        r_size--;

        for (int i = 0; i < d_size - 1; i++) {
            dire[i] = dire[i + 1];
        }
        d_size--;
    }

    free(radiant);
    free(dire);

    return r_size > 0 ? "Radiant" : "Dire";
}