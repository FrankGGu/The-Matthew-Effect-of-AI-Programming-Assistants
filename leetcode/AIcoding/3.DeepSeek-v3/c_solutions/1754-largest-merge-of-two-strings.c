char* largestMerge(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    char* merge = (char*)malloc(sizeof(char) * (len1 + len2 + 1));
    int i = 0, j = 0, k = 0;

    while (i < len1 && j < len2) {
        if (strcmp(word1 + i, word2 + j) > 0) {
            merge[k++] = word1[i++];
        } else {
            merge[k++] = word2[j++];
        }
    }

    while (i < len1) {
        merge[k++] = word1[i++];
    }

    while (j < len2) {
        merge[k++] = word2[j++];
    }

    merge[k] = '\0';
    return merge;
}