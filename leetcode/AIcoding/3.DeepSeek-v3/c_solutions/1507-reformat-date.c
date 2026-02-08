char * reformatDate(char * date){
    char *months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    char day[3] = {0};
    char month[4] = {0};
    int year;

    sscanf(date, "%s %s %d", day, month, &year);

    int day_num = 0;
    for(int i = 0; day[i]; i++) {
        if(isdigit(day[i])) {
            day_num = day_num * 10 + (day[i] - '0');
        }
    }

    int month_num = 0;
    for(int i = 0; i < 12; i++) {
        if(strcmp(month, months[i]) == 0) {
            month_num = i + 1;
            break;
        }
    }

    char *result = malloc(11 * sizeof(char));
    sprintf(result, "%d-%02d-%02d", year, month_num, day_num);

    return result;
}