typedef struct {
    char ch;
    int count;
} CharCount;

int compare(const void* a, const void* b) {
    return ((CharCount*)b)->count - ((CharCount*)a)->count;
}

char* frequencySort(char* s) {
    int freq[128] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[(int)s[i]]++;
    }

    CharCount arr[128];
    int arrSize = 0;

    for (int i = 0; i < 128; i++) {
        if (freq[i] > 0) {
            arr[arrSize].ch = (char)i;
            arr[arrSize].count = freq[i];
            arrSize++;
        }
    }

    qsort(arr, arrSize, sizeof(CharCount), compare);

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arr[i].count; j++) {
            result[idx++] = arr[i].ch;
        }
    }
    result[idx] = '\0';

    return result;
}