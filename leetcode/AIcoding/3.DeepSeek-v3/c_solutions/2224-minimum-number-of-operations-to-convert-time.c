int convertTime(char * current, char * correct){
    int curr_h = (current[0] - '0') * 10 + (current[1] - '0');
    int curr_m = (current[3] - '0') * 10 + (current[4] - '0');
    int corr_h = (correct[0] - '0') * 10 + (correct[1] - '0');
    int corr_m = (correct[3] - '0') * 10 + (correct[4] - '0');

    int curr_total = curr_h * 60 + curr_m;
    int corr_total = corr_h * 60 + corr_m;

    int diff = corr_total - curr_total;
    if (diff < 0) diff += 24 * 60;

    int ops = 0;
    ops += diff / 60;
    diff %= 60;
    ops += diff / 15;
    diff %= 15;
    ops += diff / 5;
    diff %= 5;
    ops += diff;

    return ops;
}