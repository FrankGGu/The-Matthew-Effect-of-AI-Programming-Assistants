typedef struct {
    char* name;
    int count;
} Sender;

int countWords(char* message) {
    int count = 0;
    int inWord = 0;
    for (int i = 0; message[i]; i++) {
        if (message[i] == ' ') {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            count++;
        }
    }
    return count;
}

char* largestWordCount(char** messages, int messagesSize, char** senders, int sendersSize) {
    Sender* senderCounts = (Sender*)malloc(sendersSize * sizeof(Sender));
    int uniqueSenders = 0;

    for (int i = 0; i < sendersSize; i++) {
        int found = -1;
        for (int j = 0; j < uniqueSenders; j++) {
            if (strcmp(senders[i], senderCounts[j].name) == 0) {
                found = j;
                break;
            }
        }

        int wordCount = countWords(messages[i]);

        if (found != -1) {
            senderCounts[found].count += wordCount;
        } else {
            senderCounts[uniqueSenders].name = senders[i];
            senderCounts[uniqueSenders].count = wordCount;
            uniqueSenders++;
        }
    }

    int maxCount = -1;
    char* result = NULL;

    for (int i = 0; i < uniqueSenders; i++) {
        if (senderCounts[i].count > maxCount || 
            (senderCounts[i].count == maxCount && strcmp(senderCounts[i].name, result) > 0)) {
            maxCount = senderCounts[i].count;
            result = senderCounts[i].name;
        }
    }

    free(senderCounts);
    return result;
}