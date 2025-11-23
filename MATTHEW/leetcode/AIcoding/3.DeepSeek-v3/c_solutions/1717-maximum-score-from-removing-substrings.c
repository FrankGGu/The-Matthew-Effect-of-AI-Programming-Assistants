int maxGain(char* s, char* highGain, char* lowGain) {
    int highGainPoints = (highGain[0] == 'a') ? 1 : 2;
    int lowGainPoints = (highGainPoints == 1) ? 2 : 1;

    int len = strlen(s);
    char* stack = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    int score = 0;

    for (int i = 0; i < len; i++) {
        if (top >= 0 && stack[top] == highGain[0] && s[i] == highGain[1]) {
            score += highGainPoints;
            top--;
        } else {
            stack[++top] = s[i];
        }
    }

    char* remaining = (char*)malloc((top + 2) * sizeof(char));
    for (int i = 0; i <= top; i++) {
        remaining[i] = stack[i];
    }
    remaining[top + 1] = '\0';

    top = -1;
    for (int i = 0; i < strlen(remaining); i++) {
        if (top >= 0 && stack[top] == lowGain[0] && remaining[i] == lowGain[1]) {
            score += lowGainPoints;
            top--;
        } else {
            stack[++top] = remaining[i];
        }
    }

    free(stack);
    free(remaining);

    return score;
}

int maximumGain(char* s, int x, int y) {
    char highGain[3], lowGain[3];

    if (x >= y) {
        strcpy(highGain, "ab");
        strcpy(lowGain, "ba");
    } else {
        strcpy(highGain, "ba");
        strcpy(lowGain, "ab");
    }

    return maxGain(s, highGain, lowGain);
}