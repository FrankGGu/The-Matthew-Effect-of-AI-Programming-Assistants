int minimumAddedCoins(int* coins, int coinsSize, int target) {
    int count = 0;
    long long reach = 0;
    int i = 0;

    while (reach < target) {
        if (i < coinsSize && coins[i] <= reach + 1) {
            reach += coins[i];
            i++;
        } else {
            reach += reach + 1;
            count++;
        }
    }

    return count;
}