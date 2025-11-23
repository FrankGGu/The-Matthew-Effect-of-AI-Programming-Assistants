char* originalDigits(char* s) {
    int count[26] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }

    int digits[10] = {0};

    digits[0] = count['z' - 'a'];
    digits[2] = count['w' - 'a'];
    digits[4] = count['u' - 'a'];
    digits[6] = count['x' - 'a'];
    digits[8] = count['g' - 'a'];

    digits[3] = count['h' - 'a'] - digits[8];
    digits[5] = count['f' - 'a'] - digits[4];
    digits[7] = count['s' - 'a'] - digits[6];

    digits[1] = count['o' - 'a'] - digits[0] - digits[2] - digits[4];
    digits[9] = count['i' - 'a'] - digits[5] - digits[6] - digits[8];

    char* result = malloc(50000 * sizeof(char));
    int pos = 0;
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < digits[i]; j++) {
            result[pos++] = '0' + i;
        }
    }
    result[pos] = '\0';
    return result;
}