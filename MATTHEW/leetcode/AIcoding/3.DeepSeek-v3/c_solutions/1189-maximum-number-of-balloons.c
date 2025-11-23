int maxNumberOfBalloons(char* text) {
    int count[26] = {0};
    for (int i = 0; text[i] != '\0'; i++) {
        count[text[i] - 'a']++;
    }

    int min = count['b' - 'a'];
    if (count['a' - 'a'] < min) min = count['a' - 'a'];
    if (count['l' - 'a'] / 2 < min) min = count['l' - 'a'] / 2;
    if (count['o' - 'a'] / 2 < min) min = count['o' - 'a'] / 2;
    if (count['n' - 'a'] < min) min = count['n' - 'a'];

    return min;
}