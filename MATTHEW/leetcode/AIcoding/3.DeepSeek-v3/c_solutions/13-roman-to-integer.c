int romanToInt(char* s) {
    int values[26];
    values['I' - 'A'] = 1;
    values['V' - 'A'] = 5;
    values['X' - 'A'] = 10;
    values['L' - 'A'] = 50;
    values['C' - 'A'] = 100;
    values['D' - 'A'] = 500;
    values['M' - 'A'] = 1000;

    int result = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int current = values[s[i] - 'A'];
        if (i < n - 1 && current < values[s[i + 1] - 'A']) {
            result -= current;
        } else {
            result += current;
        }
    }

    return result;
}