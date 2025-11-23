#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countPowerfulIntegers(long long start, long long finish, int power, int power_len) {
    char start_str[20], finish_str[20];
    sprintf(start_str, "%lld", start);
    sprintf(finish_str, "%lld", finish);
    int start_len = strlen(start_str), finish_len = strlen(finish_str);
    long long ans = 0;

    for (int len = power_len; len <= finish_len; len++) {
        long long upper_bound = (long long)pow(10, len) - 1;
        long long cur_power = (long long)power;
        for (int i = 1; i < len - power_len; i++) {
            cur_power *= 10;
        }
        upper_bound = upper_bound - power;

        long long lower_bound = (long long)pow(10, len - 1);
        lower_bound = lower_bound - 1 + 1;
        lower_bound = lower_bound - power;

        if (len < finish_len) {

            if (lower_bound <= upper_bound)
             ans += (upper_bound - lower_bound + 1 > 0) ? (upper_bound - lower_bound + 1) : 0;
        } else {
            upper_bound = finish - power;

            if (lower_bound > upper_bound) continue;

            if(len > start_len)
            {
                 ans += (upper_bound - lower_bound + 1 > 0) ? (upper_bound - lower_bound + 1) : 0;
            }
            else
            {
                lower_bound = start - power;

                 if (lower_bound > upper_bound) continue;

                ans += (upper_bound - lower_bound + 1 > 0) ? (upper_bound - lower_bound + 1) : 0;
            }

        }

    }
    return ans;
}