char* intToRoman(int num) {
    static char* romanNumerals[] = {
        "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"
    };
    int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    char* result = (char*)malloc(16 * sizeof(char));
    int index = 0;

    for (int i = 0; i < 13; i++) {
        while (num >= values[i]) {
            num -= values[i];
            strcpy(result + index, romanNumerals[i]);
            index += strlen(romanNumerals[i]);
        }
    }
    result[index] = '\0';
    return result;
}