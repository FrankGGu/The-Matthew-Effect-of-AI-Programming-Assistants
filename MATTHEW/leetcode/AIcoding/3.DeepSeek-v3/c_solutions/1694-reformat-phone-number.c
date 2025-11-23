char * reformatNumber(char * number){
    int len = strlen(number);
    int digits = 0;
    for(int i = 0; i < len; i++) {
        if(isdigit(number[i])) digits++;
    }

    char* result = (char*)malloc(digits * 2);
    int idx = 0;
    int count = 0;

    for(int i = 0; i < len; i++) {
        if(isdigit(number[i])) {
            if(count > 0 && count % 3 == 0) {
                result[idx++] = '-';
            }
            result[idx++] = number[i];
            count++;
        }
    }

    if(count % 3 == 1) {
        char temp = result[idx-3];
        result[idx-3] = '-';
        result[idx-2] = temp;
        result[idx-1] = result[idx-2];
        result[idx-2] = result[idx-1];
    }

    result[idx] = '\0';

    if(count % 3 == 1 && count > 3) {
        char temp = result[idx-3];
        result[idx-3] = result[idx-2];
        result[idx-2] = temp;
    }

    return result;
}