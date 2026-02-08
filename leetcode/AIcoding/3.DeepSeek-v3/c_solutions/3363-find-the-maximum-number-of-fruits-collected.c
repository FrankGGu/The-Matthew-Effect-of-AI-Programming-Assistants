int max(int a, int b) {
    return a > b ? a : b;
}

int totalFruit(int* fruits, int fruitsSize) {
    int last_fruit = -1;
    int second_last_fruit = -1;
    int last_fruit_count = 0;
    int current_max = 0;
    int max_count = 0;

    for (int i = 0; i < fruitsSize; i++) {
        if (fruits[i] == last_fruit || fruits[i] == second_last_fruit) {
            current_max++;
        } else {
            current_max = last_fruit_count + 1;
        }

        if (fruits[i] == last_fruit) {
            last_fruit_count++;
        } else {
            last_fruit_count = 1;
            second_last_fruit = last_fruit;
            last_fruit = fruits[i];
        }

        max_count = max(max_count, current_max);
    }

    return max_count;
}