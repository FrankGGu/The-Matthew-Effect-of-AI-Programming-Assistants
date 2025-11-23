#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int dp_value;
} WordEntry;

int compareWordEntries(const void* a, const void* b) {
    WordEntry* entryA = (WordEntry*)a;
    WordEntry* entryB = (WordEntry*)b;
    return strlen(entryA->word) - strlen(entryB->word);
}

int isPredecessor(const char* s1, const char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len2 != len1 + 1) {
        return 0;
    }

    int p1 = 0;
    int p2 = 0;
    int diff_count = 0;

    while (p1 < len1 && p2 < len2) {
        if (s1[p1] == s2[p2]) {
            p1++;
            p2++;
        } else {
            diff_count++;
            if (diff_count > 1) {
                return 0;
            }
            p2++;
        }
    }
    return (p1 == len1 && diff_count <= 1);
}

int longestStrChain(char** words, int wordsSize) {
    if (wordsSize == 0) {
        return 0;
    }

    WordEntry* entries = (WordEntry*)malloc(wordsSize * sizeof(WordEntry));
    if (entries == NULL) {
        return 0;
    }

    for (int i = 0; i < wordsSize; i++) {
        entries[i].word = words[i];
        entries[i].dp_value = 1;
    }

    qsort(entries, wordsSize, sizeof(WordEntry), compareWordEntries);

    int max_chain_length = 1;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (isPredecessor(entries[j].word, entries[i].word)) {
                if (entries[j].dp_value + 1 > entries[i].dp_value) {
                    entries[i].dp_value = entries[j].dp_value + 1;
                }
            }
        }
        if (entries[i].dp_value > max_chain_length) {
            max_chain_length = entries[i].dp_value;
        }
    }

    free(entries);

    return max_chain_length;
}