char *entityParser(char *text) {
    char *result = malloc(3 * strlen(text) + 1);
    char *ptr = result;
    while (*text) {
        if (*text == '&') {
            if (strncmp(text, "&quot;", 6) == 0) {
                strcpy(ptr, "\"");
                ptr += 1;
                text += 6;
            } else if (strncmp(text, "&apos;", 6) == 0) {
                strcpy(ptr, "'");
                ptr += 1;
                text += 6;
            } else if (strncmp(text, "&amp;", 5) == 0) {
                strcpy(ptr, "&");
                ptr += 1;
                text += 5;
            } else if (strncmp(text, "&gt;", 4) == 0) {
                strcpy(ptr, ">");
                ptr += 1;
                text += 4;
            } else if (strncmp(text, "&lt;", 4) == 0) {
                strcpy(ptr, "<");
                ptr += 1;
                text += 4;
            } else {
                *ptr++ = *text++;
            }
        } else {
            *ptr++ = *text++;
        }
    }
    *ptr = '\0';
    return result;
}