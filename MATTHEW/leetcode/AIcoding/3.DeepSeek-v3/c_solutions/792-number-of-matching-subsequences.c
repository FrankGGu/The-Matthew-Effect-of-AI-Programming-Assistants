typedef struct {
    char* word;
    int index;
} Node;

int numMatchingSubseq(char* s, char** words, int wordsSize) {
    Node* buckets[26] = {NULL};
    int counts[26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        char firstChar = words[i][0];
        int bucketIndex = firstChar - 'a';
        counts[bucketIndex]++;

        if (buckets[bucketIndex] == NULL) {
            buckets[bucketIndex] = malloc(counts[bucketIndex] * sizeof(Node));
        } else {
            buckets[bucketIndex] = realloc(buckets[bucketIndex], counts[bucketIndex] * sizeof(Node));
        }

        buckets[bucketIndex][counts[bucketIndex] - 1].word = words[i];
        buckets[bucketIndex][counts[bucketIndex] - 1].index = 0;
    }

    int result = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        char c = s[i];
        int bucketIndex = c - 'a';

        int currentCount = counts[bucketIndex];
        counts[bucketIndex] = 0;

        for (int j = 0; j < currentCount; j++) {
            Node node = buckets[bucketIndex][j];
            node.index++;

            if (node.word[node.index] == '\0') {
                result++;
            } else {
                char nextChar = node.word[node.index];
                int nextBucketIndex = nextChar - 'a';
                counts[nextBucketIndex]++;

                if (buckets[nextBucketIndex] == NULL) {
                    buckets[nextBucketIndex] = malloc(counts[nextBucketIndex] * sizeof(Node));
                } else {
                    buckets[nextBucketIndex] = realloc(buckets[nextBucketIndex], counts[nextBucketIndex] * sizeof(Node));
                }

                buckets[nextBucketIndex][counts[nextBucketIndex] - 1] = node;
            }
        }

        free(buckets[bucketIndex]);
        buckets[bucketIndex] = NULL;
    }

    for (int i = 0; i < 26; i++) {
        if (buckets[i] != NULL) {
            free(buckets[i]);
        }
    }

    return result;
}