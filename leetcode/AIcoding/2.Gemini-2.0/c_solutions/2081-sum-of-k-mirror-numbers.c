#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long reverse(long long n, int base) {
    long long reversed = 0;
    while (n > 0) {
        reversed = reversed * base + n % base;
        n /= base;
    }
    return reversed;
}

bool isPalindrome(long long n, int base) {
    return n == reverse(n, base);
}

long long kMirror(int k, int n) {
    long long sum = 0;
    int count = 0;
    long long i = 1;
    while (count < n) {
        long long num = i;
        long long temp = i;
        long long p = 10;
        while (temp > 0) {
            temp /= 10;
            p *= 10;
        }
        p /= 10;

        while (num > 0){
            long long rev = reverse(num/p, 10);
            num = num%p;
            i = i *10 + rev%10;
            p = p/10;
            if (p == 0){
                break;
            }
        }

        temp = i;
        if (isPalindrome(temp, k)){
            sum += temp;
            count++;
        }

        i = i/10 +1;
        if (i %10 == 0){
            i = i/10 +1;
        }
        temp = i;
    }
    return sum;
}