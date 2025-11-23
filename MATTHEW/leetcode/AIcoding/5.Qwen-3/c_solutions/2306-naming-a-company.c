#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int count;
} NameCount;

int compare(const void* a, const void* b) {
    return ((NameCount*)b)->count - ((NameCount*)a)->count;
}

char* getCommonPrefix(char* s1, char* s2) {
    int len = 0;
    while (s1[len] && s2[len] && s1[len] == s2[len]) {
        len++;
    }
    char* prefix = (char*)malloc(len + 1);
    strncpy(prefix, s1, len);
    prefix[len] = '\0';
    return prefix;
}

char* getCommonSuffix(char* s1, char* s2) {
    int len1 = strlen(s1), len2 = strlen(s2);
    int len = 0;
    while (len1 > 0 && len2 > 0 && s1[len1 - 1] == s2[len2 - 1]) {
        len++;
        len1--;
        len2--;
    }
    char* suffix = (char*)malloc(len + 1);
    for (int i = 0; i < len; i++) {
        suffix[i] = s1[strlen(s1) - len + i];
    }
    suffix[len] = '\0';
    return suffix;
}

char* getMinUniquePrefix(char* s, char** names, int namesSize) {
    int prefixLen = 0;
    while (1) {
        int unique = 1;
        for (int i = 0; i < namesSize; i++) {
            if (i != 0 && strncmp(s, names[i], prefixLen) == 0) {
                unique = 0;
                break;
            }
        }
        if (unique) {
            char* result = (char*)malloc(prefixLen + 1);
            strncpy(result, s, prefixLen);
            result[prefixLen] = '\0';
            return result;
        }
        prefixLen++;
    }
}

char* getMinUniqueSuffix(char* s, char** names, int namesSize) {
    int suffixLen = 0;
    while (1) {
        int unique = 1;
        for (int i = 0; i < namesSize; i++) {
            if (i != 0 && strncmp(s + strlen(s) - suffixLen, names[i] + strlen(names[i]) - suffixLen, suffixLen) == 0) {
                unique = 0;
                break;
            }
        }
        if (unique) {
            char* result = (char*)malloc(suffixLen + 1);
            strncpy(result, s + strlen(s) - suffixLen, suffixLen);
            result[suffixLen] = '\0';
            return result;
        }
        suffixLen++;
    }
}

char* getMinUniqueName(char* s, char** names, int namesSize) {
    char* prefix = getMinUniquePrefix(s, names, namesSize);
    char* suffix = getMinUniqueSuffix(s, names, namesSize);
    int totalLen = strlen(prefix) + strlen(suffix) + 1;
    char* result = (char*)malloc(totalLen);
    strcpy(result, prefix);
    strcat(result, suffix);
    free(prefix);
    free(suffix);
    return result;
}

char* getNames(char** names, int namesSize) {
    NameCount* counts = (NameCount*)malloc(namesSize * sizeof(NameCount));
    for (int i = 0; i < namesSize; i++) {
        counts[i].name = names[i];
        counts[i].count = 1;
    }

    for (int i = 0; i < namesSize; i++) {
        for (int j = i + 1; j < namesSize; j++) {
            if (strcmp(counts[i].name, counts[j].name) == 0) {
                counts[i].count++;
                counts[j].count = 0;
            }
        }
    }

    qsort(counts, namesSize, sizeof(NameCount), compare);

    char* result = (char*)malloc(1);
    result[0] = '\0';

    for (int i = 0; i < namesSize; i++) {
        if (counts[i].count == 0) continue;
        char* uniqueName = getMinUniqueName(counts[i].name, names, namesSize);
        int len = strlen(result) + strlen(uniqueName) + 1;
        char* newResult = (char*)malloc(len);
        strcpy(newResult, result);
        strcat(newResult, uniqueName);
        strcat(newResult, " ");
        free(result);
        result = newResult;
        free(uniqueName);
    }

    int len = strlen(result);
    if (len > 0) {
        result[len - 1] = '\0';
    }

    free(counts);
    return result;
}