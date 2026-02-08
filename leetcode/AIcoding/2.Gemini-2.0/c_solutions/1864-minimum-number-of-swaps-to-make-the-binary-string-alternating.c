#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwaps(char * s){
    int n = 0;
    while(s[n] != '\0'){
        n++;
    }

    int zeros_even = 0;
    int zeros_odd = 0;

    for(int i = 0; i < n; i++){
        if(s[i] == '0'){
            if(i % 2 == 0){
                zeros_even++;
            } else {
                zeros_odd++;
            }
        }
    }

    int ones_even = 0;
    int ones_odd = 0;

    for(int i = 0; i < n; i++){
        if(s[i] == '1'){
            if(i % 2 == 0){
                ones_even++;
            } else {
                ones_odd++;
            }
        }
    }

    if (abs(zeros_even + zeros_odd - ones_even - ones_odd) > 1) {
        return -1;
    }

    int ans = INT_MAX;

    if((zeros_even + zeros_odd) == (ones_even + ones_odd)){
        ans = fmin(zeros_even, ones_even);
    } else if ((zeros_even + zeros_odd) > (ones_even + ones_odd)) {
        ans = zeros_even;
    } else {
        ans = ones_even;
    }

    int ans2 = INT_MAX;
    if((zeros_even + zeros_odd) == (ones_even + ones_odd)){
        ans2 = fmin(zeros_odd, ones_odd);
    } else if ((zeros_even + zeros_odd) < (ones_even + ones_odd)) {
        ans2 = ones_odd;
    } else {
        ans2 = zeros_odd;
    }

    if ((zeros_even + zeros_odd) == (ones_even + ones_odd)) {
        return fmin(ans, ans2);
    } else if ((zeros_even + zeros_odd) > (ones_even + ones_odd)) {
         return zeros_even;
    } else {
        return ones_even;
    }
}