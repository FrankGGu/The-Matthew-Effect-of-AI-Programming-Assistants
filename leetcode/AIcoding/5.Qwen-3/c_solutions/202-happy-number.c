#include <stdio.h>
#include <stdlib.h>

int get_next(int n) {
    int total = 0;
    while (n > 0) {
        int digit = n % 10;
        total += digit * digit;
        n /= 10;
    }
    return total;
}

bool is_happy(int n) {
    int slow = n;
    int fast = get_next(n);
    while (fast != 1 && slow != fast) {
        slow = get_next(slow);
        fast = get_next(get_next(fast));
    }
    return fast == 1;
}