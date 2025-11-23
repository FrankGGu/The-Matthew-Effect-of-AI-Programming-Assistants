char* compressedString(char* word) {
    int len = strlen(word);
    char* comp = (char*)malloc(2 * len + 1);
    int comp_index = 0;
    int i = 0;

    while (i < len) {
        char current_char = word[i];
        int count = 0;

        while (i < len && word[i] == current_char && count < 9) {
            count++;
            i++;
        }

        comp[comp_index++] = count + '0';
        comp[comp_index++] = current_char;
    }

    comp[comp_index] = '\0';
    return comp;
}