#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lastRemaining(int n) {
    int head = 1;
    int step = 1;
    int remaining = n;
    int left = 1; 

    while (remaining > 1) {
        if (left) {
            head = head + step;
        } else {
            if (remaining % 2 == 1) {
                head = head + step;
            }
        }

        remaining = remaining / 2;
        step = step * 2;
        left = 1 - left; 
    }

    return head;
}