int minCost(int* chips, int chipsSize) {
    int odd = 0, even = 0;
    for (int i = 0; i < chipsSize; i++) {
        if (chips[i] % 2 == 0) {
            even++;
        } else {
            odd++;
        }
    }
    return odd < even ? odd : even;
}