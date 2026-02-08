#include <stdio.h>
#include <stdlib.h>

double taxBrackets[100][2];
int taxBracketsSize;

double calculateTax(int* brackets, int bracketsSize) {
    double total = 0.0;
    int prev = 0;
    for (int i = 0; i < bracketsSize; i += 2) {
        int level = brackets[i];
        double rate = brackets[i + 1] / 100.0;
        int diff = level - prev;
        total += diff * rate;
        prev = level;
    }
    return total;
}