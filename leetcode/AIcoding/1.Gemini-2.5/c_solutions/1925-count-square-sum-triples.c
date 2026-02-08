#include <math.h>

int countTriples(int n) {
    int count = 0;
    for (int a = 1; a <= n; a++) {
        for (int b = 1; b <= n; b++) {
            int sum_squares = a * a + b * b;
            double c_double = sqrt((double)sum_squares);
            int c = (int)c_double;
            if (c * c == sum_squares && c <= n) {
                count++;
            }
        }
    }
    return count;
}