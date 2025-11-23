char* reversePrefix(char* word, char ch) {
    int idx = -1;
    for (int i = 0; word[i] != '\0'; i++) {
        if (word[i] == ch) {
            idx = i;
            break;
        }
    }

    if (idx == -1) return word;

    int left = 0, right = idx;
    while (left < right) {
        char temp = word[left];
        word[left] = word[right];
        word[right] = temp;
        left++;
        right--;
    }

    return word;
}