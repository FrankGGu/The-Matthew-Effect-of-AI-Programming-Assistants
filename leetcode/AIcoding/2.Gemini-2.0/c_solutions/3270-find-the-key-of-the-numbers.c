#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheKey(int num) {
    int key = 0;
    while (num > 0) {
        key += num % 10;
        num /= 10;
    }
    while (key >= 10) {
        int temp = 0;
        while (key > 0) {
            temp += key % 10;
            key /= 10;
        }
        key = temp;
    }
    return key;
}