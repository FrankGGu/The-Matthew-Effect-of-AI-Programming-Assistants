char * replaceDigits(char * s){
    int i = 0;
    while (s[i] != '\0') {
        if (i % 2 != 0) {
            s[i] = s[i-1] + (s[i] - '0');
        }
        i++;
    }
    return s;
}