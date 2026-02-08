int breakfastNumber(int* staple, int stapleSize, int* drinks, int drinksSize, int x){
    const int MOD = 1000000007;
    int count = 0;

    // Sort both arrays
    qsort(staple, stapleSize, sizeof(int), cmpfunc);
    qsort(drinks, drinksSize, sizeof(int), cmpfunc);

    int i = 0;
    int j = drinksSize - 1;

    while (i < stapleSize && j >= 0) {
        if (staple[i] + drinks[j] <= x) {
            count = (count + j + 1) % MOD;
            i++;
        } else {
            j--;
        }
    }

    return count;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}