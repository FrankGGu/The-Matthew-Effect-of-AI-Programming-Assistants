int uniqueMorseRepresentations(char** words, int wordsSize) {
    char* morse[] = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
    char transformations[100][60] = {0};
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char code[50] = {0};
        char* word = words[i];
        int len = strlen(word);

        for (int j = 0; j < len; j++) {
            strcat(code, morse[word[j] - 'a']);
        }

        int found = 0;
        for (int k = 0; k < count; k++) {
            if (strcmp(transformations[k], code) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            strcpy(transformations[count], code);
            count++;
        }
    }

    return count;
}