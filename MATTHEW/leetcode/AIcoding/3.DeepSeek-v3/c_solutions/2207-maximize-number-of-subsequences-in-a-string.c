long long maximumSubsequenceCount(char* text, char* pattern) {
    long long count1 = 0, count2 = 0, result = 0;
    char first = pattern[0], second = pattern[1];

    for (int i = 0; text[i] != '\0'; i++) {
        if (text[i] == second) {
            result += count1;
            count2++;
        }
        if (text[i] == first) {
            count1++;
        }
    }

    return result + (count1 > count2 ? count1 : count2);
}