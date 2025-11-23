char *largestWordCount(char **messages, int messagesSize, char **senders, int sendersSize) {
    int maxCount = 0;
    char *result = NULL;
    int *wordCounts = (int *)calloc(sendersSize, sizeof(int));

    for (int i = 0; i < messagesSize; i++) {
        int count = 1;
        for (char *c = messages[i]; *c; c++) {
            if (*c == ' ') count++;
        }
        for (int j = 0; j < sendersSize; j++) {
            if (strcmp(senders[j], senders[i]) == 0) {
                wordCounts[j] += count;
                if (wordCounts[j] > maxCount || (wordCounts[j] == maxCount && (!result || strcmp(senders[j], result) > 0))) {
                    maxCount = wordCounts[j];
                    result = senders[j];
                }
                break;
            }
        }
    }

    free(wordCounts);
    return result;
}