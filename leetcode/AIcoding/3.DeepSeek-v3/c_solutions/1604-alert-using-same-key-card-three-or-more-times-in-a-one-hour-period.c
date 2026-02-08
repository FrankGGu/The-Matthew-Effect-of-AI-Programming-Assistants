#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    char* name;
    int time;
} Entry;

int cmp(const void* a, const void* b) {
    Entry* ea = (Entry*)a;
    Entry* eb = (Entry*)b;
    int name_cmp = strcmp(ea->name, eb->name);
    if (name_cmp != 0) return name_cmp;
    return ea->time - eb->time;
}

char** alertNames(char** keyName, int keyNameSize, char** keyTime, int keyTimeSize, int* returnSize) {
    int n = keyNameSize;
    Entry* entries = (Entry*)malloc(n * sizeof(Entry));
    for (int i = 0; i < n; i++) {
        entries[i].name = keyName[i];
        int hours = (keyTime[i][0] - '0') * 10 + (keyTime[i][1] - '0');
        int minutes = (keyTime[i][3] - '0') * 10 + (keyTime[i][4] - '0');
        entries[i].time = hours * 60 + minutes;
    }

    qsort(entries, n, sizeof(Entry), cmp);

    char** result = (char**)malloc(n * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        if (i > 0 && strcmp(entries[i].name, entries[i-1].name) == 0) continue;

        int count = 1;
        int j = i + 1;
        while (j < n && strcmp(entries[i].name, entries[j].name) == 0) {
            if (entries[j].time - entries[i].time <= 60) {
                count++;
                if (count >= 3) break;
            }
            j++;
        }

        if (count >= 3) {
            result[*returnSize] = (char*)malloc((strlen(entries[i].name) + 1) * sizeof(char));
            strcpy(result[*returnSize], entries[i].name);
            (*returnSize)++;
            continue;
        }

        for (int k = i + 1; k < n && strcmp(entries[i].name, entries[k].name) == 0; k++) {
            count = 1;
            int l = k + 1;
            while (l < n && strcmp(entries[i].name, entries[l].name) == 0) {
                if (entries[l].time - entries[k].time <= 60) {
                    count++;
                    if (count >= 3) break;
                }
                l++;
            }
            if (count >= 3) {
                result[*returnSize] = (char*)malloc((strlen(entries[i].name) + 1) * sizeof(char));
                strcpy(result[*returnSize], entries[i].name);
                (*returnSize)++;
                break;
            }
        }
    }

    free(entries);
    return result;
}