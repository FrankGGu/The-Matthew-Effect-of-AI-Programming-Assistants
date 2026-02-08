#include <stdio.h>
#include <stdlib.h>

int countTriples(int n) {
    int count = 0;
    for (int a = 1; a <= n; a++) {
        for (int b = 1; b <= n; b++) {
            int sum = a * a + b * b;
            int c = (int)sqrt(sum);
            if (c * c == sum && c <= n) {
                count++;
            }
        }
    }
    return count;
}