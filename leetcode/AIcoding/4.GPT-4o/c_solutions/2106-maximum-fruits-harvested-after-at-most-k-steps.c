int maxFruits(int* fruits, int fruitsSize, int k) {
    int left = 0, right = 0, maxFruits = 0, currentFruits = 0;

    while (right < fruitsSize) {
        currentFruits += fruits[right];

        while (right - left + 1 > k) {
            currentFruits -= fruits[left];
            left++;
        }

        maxFruits = fmax(maxFruits, currentFruits);
        right++;
    }

    return maxFruits;
}