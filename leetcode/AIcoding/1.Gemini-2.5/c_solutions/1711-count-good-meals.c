#include <stdlib.h>
#include <string.h>

#define MAX_DELICIOUSNESS (1 << 20)
#define MOD 1000000007

static int freq[MAX_DELICIOUSNESS + 1];

int countGoodMeals(int* deliciousness, int deliciousnessSize) {
    memset(freq, 0, sizeof(freq));

    long long goodMealsCount = 0;

    for (int i = 0; i < deliciousnessSize; i++) {
        int currentDeliciousness = deliciousness[i];

        for (int powerOfTwo = 1; powerOfTwo <= (1 << 21); powerOfTwo <<= 1) {
            int targetDeliciousness = powerOfTwo - currentDeliciousness;

            if (targetDeliciousness >= 0 && targetDeliciousness <= MAX_DELICIOUSNESS) {
                goodMealsCount = (goodMealsCount + freq[targetDeliciousness]) % MOD;
            }
        }

        freq[currentDeliciousness]++;
    }

    return (int)goodMealsCount;
}