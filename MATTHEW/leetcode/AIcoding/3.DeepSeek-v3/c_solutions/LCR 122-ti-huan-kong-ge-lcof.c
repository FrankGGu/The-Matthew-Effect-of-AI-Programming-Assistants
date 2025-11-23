char* pathEncryption(char* path) {
    int len = strlen(path);
    for (int i = 0; i < len; i++) {
        if (path[i] == '.') {
            path[i] = ' ';
        }
    }
    return path;
}