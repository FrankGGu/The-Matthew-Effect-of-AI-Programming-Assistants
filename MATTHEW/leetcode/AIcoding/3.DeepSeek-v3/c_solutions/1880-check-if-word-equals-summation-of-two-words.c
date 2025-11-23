int convert(char* word) {
    int num = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        num = num * 10 + (word[i] - 'a');
    }
    return num;
}

bool isSumEqual(char* firstWord, char* secondWord, char* targetWord) {
    return convert(firstWord) + convert(secondWord) == convert(targetWord);
}