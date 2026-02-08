char greatestLetter(char * s){
    int upper[26] = {0}, lower[26] = {0};
    char result = '\0';

    while (*s) {
        if (*s >= 'A' && *s <= 'Z') {
            upper[*s - 'A'] = 1;
        } else if (*s >= 'a' && *s <= 'z') {
            lower[*s - 'a'] = 1;
        }
        s++;
    }

    for (int i = 25; i >= 0; i--) {
        if (upper[i] && lower[i]) {
            result = 'A' + i;
            break;
        }
    }

    return result;
}