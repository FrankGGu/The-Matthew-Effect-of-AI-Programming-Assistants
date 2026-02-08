int lengthOfLastWord(char * s) {
    int length = 0;
    int i = 0;

    // Find the end of the string
    while (s[i] != '\0') {
        i++;
    }
    i--; // Point to the last character

    // Skip trailing spaces
    while (i >= 0 && s[i] == ' ') {
        i--;
    }

    // Count characters of the last word
    while (i >= 0 && s[i] != ' ') {
        length++;
        i--;
    }

    return length;
}