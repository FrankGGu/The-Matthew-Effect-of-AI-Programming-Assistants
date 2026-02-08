int minFlipsMonoIncr(char * s){
    int n = strlen(s);
    int ones = 0;
    int flips = 0;

    for(int i = 0; i < n; i++) {
        if(s[i] == '1') {
            ones++;
        } else {
            flips++;
        }
        if(flips > ones) {
            flips = ones;
        }
    }

    return flips;
}