#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countGoodMeals(int* deliciousness, int deliciousnessSize){
    int count = 0;
    int freq[1048577] = {0};
    for (int i = 0; i < deliciousnessSize; i++) {
        freq[deliciousness[i]]++;
    }

    for (int i = 0; i < deliciousnessSize; i++) {
        for (int powerOfTwo = 1; powerOfTwo <= 2097152; powerOfTwo *= 2) {
            int complement = powerOfTwo - deliciousness[i];
            if (complement >= 0 && complement <= 1048576) {
                if (complement == deliciousness[i]) {
                    count = (count + (freq[complement] - 1)) % MOD;
                } else {
                    count = (count + freq[complement]) % MOD;
                }
            }
        }
    }

    return (count / 2);
}