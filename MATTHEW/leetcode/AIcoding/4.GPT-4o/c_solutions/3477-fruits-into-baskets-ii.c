int maxFruits(int* fruits, int fruitsSize) {
    int left = 0, right = 0, maxFruits = 0;
    int count[10001] = {0};
    int unique = 0;

    while (right < fruitsSize) {
        if (count[fruits[right]] == 0) unique++;
        count[fruits[right]]++;
        right++;

        while (unique > 2) {
            count[fruits[left]]--;
            if (count[fruits[left]] == 0) unique--;
            left++;
        }

        maxFruits = (right - left > maxFruits) ? (right - left) : maxFruits;
    }

    return maxFruits;
}