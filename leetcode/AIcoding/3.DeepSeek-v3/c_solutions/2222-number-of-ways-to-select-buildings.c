long long numberOfWays(char * s) {
    long long total_zero = 0, total_one = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '0') total_zero++;
        else total_one++;
    }

    long long zero_count = 0, one_count = 0;
    long long result = 0;

    for (int i = 0; s[i]; i++) {
        if (s[i] == '0') {
            result += one_count * (total_one - one_count);
            zero_count++;
        } else {
            result += zero_count * (total_zero - zero_count);
            one_count++;
        }
    }

    return result;
}