int countAsterisks(char * s){
    int count = 0;
    int in_pair = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '|') {
            in_pair = !in_pair;
        } else if (s[i] == '*' && !in_pair) {
            count++;
        }
    }
    return count;
}