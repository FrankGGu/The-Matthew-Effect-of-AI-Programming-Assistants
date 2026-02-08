int countNumbersWithUniqueDigits(int n) {
    if (n == 0) {
        return 1;
    }

    int ans = 10;
    int uniqueDigitsCount = 9; 
    int availableDigits = 9; 

    for (int i = 2; i <= n && availableDigits >= 0; i++) {
        uniqueDigitsCount = uniqueDigitsCount * availableDigits;
        ans += uniqueDigitsCount;
        availableDigits--;
    }

    return ans;
}