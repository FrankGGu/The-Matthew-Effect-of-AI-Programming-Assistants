char * reorderSpaces(char * text){
    int spaces = 0;
    int words = 0;
    int len = strlen(text);

    // Count spaces and words
    for (int i = 0; i < len; i++) {
        if (text[i] == ' ') {
            spaces++;
        } else if (i == 0 || text[i-1] == ' ') {
            words++;
        }
    }

    if (words == 1) {
        // Handle single word case
        char *result = (char*)malloc(len + 1);
        int idx = 0;

        // Copy the word
        for (int i = 0; i < len; i++) {
            if (text[i] != ' ') {
                result[idx++] = text[i];
            }
        }

        // Add all spaces at the end
        for (int i = 0; i < spaces; i++) {
            result[idx++] = ' ';
        }

        result[idx] = '\0';
        return result;
    }

    int spacesBetween = spaces / (words - 1);
    int extraSpaces = spaces % (words - 1);

    char *result = (char*)malloc(len + 1);
    int idx = 0;
    int wordCount = 0;

    for (int i = 0; i < len; i++) {
        if (text[i] != ' ') {
            result[idx++] = text[i];

            // Check if this is the end of a word
            if (i + 1 < len && text[i+1] == ' ') {
                wordCount++;
                if (wordCount < words) {
                    // Add spaces between words
                    for (int j = 0; j < spacesBetween; j++) {
                        result[idx++] = ' ';
                    }
                }
            }
        }
    }

    // Add extra spaces at the end
    for (int i = 0; i < extraSpaces; i++) {
        result[idx++] = ' ';
    }

    result[idx] = '\0';
    return result;
}