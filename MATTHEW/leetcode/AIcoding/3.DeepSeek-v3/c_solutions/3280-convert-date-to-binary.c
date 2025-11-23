char * convertDateToBinary(char * date){
    int year, month, day;
    sscanf(date, "%d-%d-%d", &year, &month, &day);

    static char result[20];
    result[0] = '\0';

    char temp[10];

    // Convert year
    for(int i = 11; i >= 0; i--) {
        if(year & (1 << i)) strcat(result, "1");
        else strcat(result, "0");
    }
    strcat(result, "-");

    // Convert month
    for(int i = 4; i >= 0; i--) {
        if(month & (1 << i)) strcat(result, "1");
        else strcat(result, "0");
    }
    strcat(result, "-");

    // Convert day
    for(int i = 4; i >= 0; i--) {
        if(day & (1 << i)) strcat(result, "1");
        else strcat(result, "0");
    }

    return result;
}