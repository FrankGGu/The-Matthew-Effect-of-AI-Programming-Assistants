#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distributeCookies(int* cookies, int cookiesSize, int k){
    int *children = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k; i++) {
        children[i] = 0;
    }

    int min_unfairness = INT_MAX;

    void backtrack(int cookie_index) {
        if (cookie_index == cookiesSize) {
            int max_cookies = 0;
            for (int i = 0; i < k; i++) {
                if (children[i] > max_cookies) {
                    max_cookies = children[i];
                }
            }
            if (max_cookies < min_unfairness) {
                min_unfairness = max_cookies;
            }
            return;
        }

        for (int i = 0; i < k; i++) {
            children[i] += cookies[cookie_index];
            backtrack(cookie_index + 1);
            children[i] -= cookies[cookie_index];
        }
    }

    backtrack(0);
    free(children);
    return min_unfairness;
}