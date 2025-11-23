#include <stdio.h>
#include <stdlib.h>

int eliminateUsers(int n, int m) {
    if (n == 0) return 0;
    int result = 0;
    for (int i = 2; i <= n; i++) {
        result = (result + m) % i;
    }
    return result;
}

int main() {
    return 0;
}