char* simplifyPath(char* path) {
    int len = strlen(path);
    char* stack = (char*)malloc(len + 1);
    int top = -1;

    for (int i = 0; i < len; i++) {
        while (i < len && path[i] == '/') i++;

        if (i >= len) break;

        int start = i;
        while (i < len && path[i] != '/') i++;
        int end = i - 1;

        int seg_len = end - start + 1;
        char* segment = path + start;

        if (seg_len == 1 && segment[0] == '.') {
            continue;
        } else if (seg_len == 2 && segment[0] == '.' && segment[1] == '.') {
            while (top >= 0 && stack[top] != '/') top--;
            if (top >= 0) top--;
        } else {
            stack[++top] = '/';
            for (int j = 0; j < seg_len; j++) {
                stack[++top] = segment[j];
            }
        }
    }

    if (top < 0) {
        stack[++top] = '/';
    }

    stack[top + 1] = '\0';
    return stack;
}