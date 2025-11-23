int lengthLongestPath(char* input) {
    int maxLen = 0;
    int stack[1000];
    int depth = 0;
    int len = strlen(input);
    int i = 0;

    stack[0] = 0;

    while (i < len) {
        int currentDepth = 0;

        while (i < len && input[i] == '\t') {
            currentDepth++;
            i++;
        }

        int isFile = 0;
        int currentLen = 0;

        while (i < len && input[i] != '\n') {
            if (input[i] == '.') {
                isFile = 1;
            }
            currentLen++;
            i++;
        }
        i++;

        while (depth >= currentDepth) {
            depth--;
        }

        if (depth == 0) {
            stack[depth + 1] = currentLen;
        } else {
            stack[depth + 1] = stack[depth] + 1 + currentLen;
        }

        depth = currentDepth + 1;

        if (isFile) {
            if (stack[depth] > maxLen) {
                maxLen = stack[depth];
            }
        }
    }

    return maxLen;
}