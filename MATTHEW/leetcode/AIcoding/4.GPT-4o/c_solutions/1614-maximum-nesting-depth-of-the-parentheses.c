int maxDepth(char * s) {
    int depth = 0, maxDepth = 0;
    while (*s) {
        if (*s == '(') {
            depth++;
            if (depth > maxDepth) {
                maxDepth = depth;
            }
        } else if (*s == ')') {
            depth--;
        }
        s++;
    }
    return maxDepth;
}