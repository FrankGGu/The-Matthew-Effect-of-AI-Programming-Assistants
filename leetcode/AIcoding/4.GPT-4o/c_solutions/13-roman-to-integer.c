int romanToInt(char * s) {
    int map[128] = {0};
    map['I'] = 1;
    map['V'] = 5;
    map['X'] = 10;
    map['L'] = 50;
    map['C'] = 100;
    map['D'] = 500;
    map['M'] = 1000;

    int total = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (map[s[i]] < map[s[i + 1]]) {
            total -= map[s[i]];
        } else {
            total += map[s[i]];
        }
    }
    return total;
}