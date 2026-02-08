char* toGoatLatin(char* sentence) {
    int len = strlen(sentence);
    char* result = (char*)malloc(10000 * sizeof(char));
    int result_index = 0;
    int word_count = 0;

    for (int i = 0; i <= len; i++) {
        if (sentence[i] == ' ' || sentence[i] == '\0') {
            word_count++;
            char first_char = sentence[i - (i > 0 ? (i - 1) : 0)];
            int word_start = i - 1;
            while (word_start >= 0 && sentence[word_start] != ' ') {
                word_start--;
            }
            word_start++;

            first_char = sentence[word_start];

            if (first_char == 'a' || first_char == 'e' || first_char == 'i' || 
                first_char == 'o' || first_char == 'u' || first_char == 'A' || 
                first_char == 'E' || first_char == 'I' || first_char == 'O' || 
                first_char == 'U') {
                for (int j = word_start; j < i; j++) {
                    result[result_index++] = sentence[j];
                }
            } else {
                for (int j = word_start + 1; j < i; j++) {
                    result[result_index++] = sentence[j];
                }
                result[result_index++] = first_char;
            }

            result[result_index++] = 'm';
            result[result_index++] = 'a';
            for (int j = 0; j < word_count; j++) {
                result[result_index++] = 'a';
            }

            if (sentence[i] == ' ') {
                result[result_index++] = ' ';
            } else {
                result[result_index++] = '\0';
            }
        }
    }

    return result;
}