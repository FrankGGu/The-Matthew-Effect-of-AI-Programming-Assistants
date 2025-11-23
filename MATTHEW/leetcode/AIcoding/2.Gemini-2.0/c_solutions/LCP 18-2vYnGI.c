#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int breakfastNumber(int* staple, int stapleSize, int* drinks, int drinksSize, int x){
    int count = 0;
    int mod = 1000000007;
    int i = 0;
    int j = drinksSize - 1;

    qsort(staple, stapleSize, sizeof(int), (int (*)(const void *,const void *))cmpfunc);
    qsort(drinks, drinksSize, sizeof(int), (int (*)(const void *,const void *))cmpfunc);

    while(i < stapleSize && j >= 0){
        if(staple[i] + drinks[j] <= x){
            count = (count + (j + 1)) % mod;
            i++;
        } else {
            j--;
        }
    }

    return count;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}