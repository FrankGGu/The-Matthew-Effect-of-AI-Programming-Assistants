int numWays(char * s) {
    int count = 0, len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == '1') count++;
    }
    if (count == 0) return (len - 1) * (len - 2) / 2;
    if (count % 3 != 0) return 0;

    int part = count / 3, first = 0, second = 0, third = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] == '1') {
            if (first < part) first++;
            else if (second < part) second++;
            else third++;
        }
        if (first == part && second == 0) second++;
    }

    long result = 1;
    for (int i = 0; i < len; i++) {
        if (s[i] == '1') {
            if (first == part && second == part) {
                result = (result * (i + 1)) % 1000000007;
                first--;
            }
            else if (second == part) {
                second--;
            }
        }
    }
    return result;
}