#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int index;
} Subsequence;

typedef struct {
    char key;
    Subsequence *subseqs;
    int size;
    int capacity;
} Bucket;

typedef struct {
    Bucket *buckets;
    int bucketCount;
} Trie;

Trie* createTrie() {
    Trie *trie = (Trie*)malloc(sizeof(Trie));
    trie->bucketCount = 26;
    trie->buckets = (Bucket*)calloc(trie->bucketCount, sizeof(Bucket));
    return trie;
}

void addSubsequence(Trie *trie, char *word) {
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        char c = word[i];
        int idx = c - 'a';
        Bucket *bucket = &trie->buckets[idx];
        if (bucket->size == bucket->capacity) {
            bucket->capacity = bucket->capacity ? bucket->capacity * 2 : 1;
            bucket->subseqs = (Subsequence*)realloc(bucket->subseqs, bucket->capacity * sizeof(Subsequence));
        }
        bucket->subseqs[bucket->size].word = strdup(word);
        bucket->subseqs[bucket->size].index = i + 1;
        bucket->size++;
    }
}

int countMatches(Trie *trie, char *s) {
    int len = strlen(s);
    int count = 0;
    for (int i = 0; i < len; i++) {
        char c = s[i];
        int idx = c - 'a';
        Bucket *bucket = &trie->buckets[idx];
        for (int j = 0; j < bucket->size; j++) {
            Subsequence *subseq = &bucket->subseqs[j];
            if (subseq->index < strlen(subseq->word) && subseq->word[subseq->index] == c) {
                subseq->index++;
                if (subseq->index == strlen(subseq->word)) {
                    count++;
                }
            }
        }
    }
    return count;
}

int numMatchingSubseq(char *s, char **words, int wordsSize) {
    Trie *trie = createTrie();
    for (int i = 0; i < wordsSize; i++) {
        addSubsequence(trie, words[i]);
    }
    int result = countMatches(trie, s);
    for (int i = 0; i < 26; i++) {
        free(trie->buckets[i].subseqs);
    }
    free(trie->buckets);
    free(trie);
    return result;
}