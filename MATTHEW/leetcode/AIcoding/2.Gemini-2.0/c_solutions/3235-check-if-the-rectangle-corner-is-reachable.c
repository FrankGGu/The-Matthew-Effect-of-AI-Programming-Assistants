#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isRectangleCornerReachable(int width, int height, int threshold) {
    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    return gcd(width - 1, height - 1) <= threshold;
}