int numSub(char * s){
    long count = 0, total = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '1') {
            count++;
            total = (total + count) % 1000000007;
        } else {
            count = 0;
        }
    }
    return total;
}