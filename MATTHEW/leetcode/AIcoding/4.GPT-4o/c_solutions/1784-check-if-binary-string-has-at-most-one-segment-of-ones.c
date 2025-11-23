bool checkOnesSegment(char * s){
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            if (i > 0 && s[i - 1] == '0') {
                count++;
            }
        }
    }
    return count <= 1;
}