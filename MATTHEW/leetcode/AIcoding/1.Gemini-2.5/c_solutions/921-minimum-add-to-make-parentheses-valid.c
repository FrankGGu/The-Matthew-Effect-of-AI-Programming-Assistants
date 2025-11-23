int minAddToMakeValid(char * s){
    int open_needed = 0;
    int close_needed = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            open_needed++;
        } else { // s[i] == ')'
            if (open_needed > 0) {
                open_needed--;
            } else {
                close_needed++;
            }
        }
    }

    return open_needed + close_needed;
}