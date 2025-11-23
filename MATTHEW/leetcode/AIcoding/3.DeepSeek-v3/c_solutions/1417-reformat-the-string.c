char * reformat(char * s){
    int len = strlen(s);
    int alpha_count = 0, digit_count = 0;

    for(int i = 0; i < len; i++) {
        if(isalpha(s[i])) alpha_count++;
        else digit_count++;
    }

    if(abs(alpha_count - digit_count) > 1) return "";

    char* result = (char*)malloc((len + 1) * sizeof(char));
    result[len] = '\0';

    int alpha_idx = 0, digit_idx = 0;
    if(alpha_count >= digit_count) {
        alpha_idx = 0;
        digit_idx = 1;
    } else {
        alpha_idx = 1;
        digit_idx = 0;
    }

    for(int i = 0; i < len; i++) {
        if(isalpha(s[i])) {
            result[alpha_idx] = s[i];
            alpha_idx += 2;
        } else {
            result[digit_idx] = s[i];
            digit_idx += 2;
        }
    }

    return result;
}