int totalFruits(int* fruits, int fruitsSize) {
    int left = 0, right = 0, maxFruits = 0;
    int count[100001] = {0};

    while (right < fruitsSize) {
        count[fruits[right]]++;

        while (count[fruits[right]] > 1 && (count[fruits[left]] > 0)) {
            count[fruits[left]]--;
            left++;
        }

        maxFruits = fmax(maxFruits, right - left + 1);
        right++;
    }

    return maxFruits;
}