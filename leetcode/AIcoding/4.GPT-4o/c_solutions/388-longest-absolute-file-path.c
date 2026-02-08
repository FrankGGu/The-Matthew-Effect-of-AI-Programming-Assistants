int lengthLongestPath(char * input) {
    int maxLength = 0;
    int currentLength = 0;
    int currentDepth = 0;
    int stack[1000] = {0}; // Assuming the max depth is 1000
    char *token = strtok(input, "\n");

    while (token != NULL) {
        int depth = 0;
        while (token[depth] == '\t') {
            depth++;
        }

        if (depth < currentDepth) {
            currentLength = stack[depth] + strlen(token + depth);
            currentDepth = depth;
        } else if (depth == currentDepth) {
            currentLength += strlen(token + depth);
        } else {
            currentLength += strlen(token + depth) + 1; // +1 for the '/'
        }

        stack[depth] = currentLength;

        if (strchr(token, '.') != NULL) {
            maxLength = maxLength > currentLength ? maxLength : currentLength;
        }

        token = strtok(NULL, "\n");
    }

    return maxLength;
}