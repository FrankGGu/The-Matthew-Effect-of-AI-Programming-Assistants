char* entityParser(char* text) {
    int len = strlen(text);
    char* result = (char*)malloc(len + 1);
    int i = 0, j = 0;

    while (i < len) {
        if (text[i] == '&') {
            if (i + 3 < len && text[i+1] == 'q' && text[i+2] == 'u' && text[i+3] == 'o' && text[i+4] == 't' && text[i+5] == ';') {
                result[j++] = '\"';
                i += 6;
            } else if (i + 3 < len && text[i+1] == 'a' && text[i+2] == 'p' && text[i+3] == 'o' && text[i+4] == 's' && text[i+5] == ';') {
                result[j++] = '\'';
                i += 6;
            } else if (i + 2 < len && text[i+1] == 'a' && text[i+2] == 'm' && text[i+3] == 'p' && text[i+4] == ';') {
                result[j++] = '&';
                i += 5;
            } else if (i + 1 < len && text[i+1] == 'g' && text[i+2] == 't' && text[i+3] == ';') {
                result[j++] = '>';
                i += 4;
            } else if (i + 1 < len && text[i+1] == 'l' && text[i+2] == 't' && text[i+3] == ';') {
                result[j++] = '<';
                i += 4;
            } else if (i + 2 < len && text[i+1] == 'f' && text[i+2] == 'r' && text[i+3] == 'a' && text[i+4] == 's' && text[i+5] == 'l' && text[i+6] == ';') {
                result[j++] = '/';
                i += 7;
            } else {
                result[j++] = text[i++];
            }
        } else {
            result[j++] = text[i++];
        }
    }

    result[j] = '\0';
    return result;
}