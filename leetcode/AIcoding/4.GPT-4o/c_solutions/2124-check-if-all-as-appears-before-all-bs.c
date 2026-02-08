bool checkString(char * s){
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] == 'b') {
            while (s[i] == 'b') i++;
            break;
        }
        i++;
    }
    while (s[i] != '\0') {
        if (s[i] == 'a') return false;
        i++;
    }
    return true;
}