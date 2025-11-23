int totalFruits(int* fruits, int fruitsSize) {
    int left = 0, right = 0, maxFruits = 0;
    int basket[3] = {0}; // To store count of fruits in two baskets

    while (right < fruitsSize) {
        if (basket[fruits[right]] == 0) {
            if (basket[0] == 0) basket[0] = fruits[right];
            else if (basket[1] == 0) basket[1] = fruits[right];
            else {
                while (basket[0] != fruits[left] && basket[1] != fruits[left]) {
                    left++;
                }
                if (basket[0] == fruits[left]) {
                    basket[0] = 0;
                } else {
                    basket[1] = 0;
                }
                left++;
            }
        }
        basket[fruits[right]]++;
        maxFruits = maxFruits > (right - left + 1) ? maxFruits : (right - left + 1);
        right++;
    }
    return maxFruits;
}