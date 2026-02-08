int maxDepthAfterSplit(char *seq) {
    int depth = 0, maxDepth = 0;
    for (int i = 0; seq[i] != '\0'; i++) {
        if (seq[i] == '(') {
            depth++;
            maxDepth = depth > maxDepth ? depth : maxDepth;
        } else {
            depth--;
        }
    }
    return (maxDepth + 1) / 2;
}