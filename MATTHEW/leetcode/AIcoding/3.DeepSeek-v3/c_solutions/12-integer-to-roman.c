char* intToRoman(int num) {
    char* roman = (char*)malloc(20 * sizeof(char));
    int index = 0;

    int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    char* symbols[] = {"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"};

    for (int i = 0; i < 13; i++) {
        while (num >= values[i]) {
            num -= values[i];
            if (symbols[i][1] == '\0') {
                roman[index++] = symbols[i][0];
            } else {
                roman[index++] = symbols[i][0];
                roman[index++] = symbols[i][1];
            }
        }
    }

    roman[index] = '\0';
    return roman;
}