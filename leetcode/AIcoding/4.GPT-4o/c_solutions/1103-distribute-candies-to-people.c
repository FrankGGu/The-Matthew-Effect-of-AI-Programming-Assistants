int* distributeCandies(int candies, int num_people, int* returnSize) {
    int* result = (int*)malloc(num_people * sizeof(int));
    *returnSize = num_people;
    for (int i = 0; i < num_people; i++) {
        result[i] = 0;
    }

    int i = 0;
    while (candies > 0) {
        result[i] += (candies >= i + 1) ? i + 1 : candies;
        candies -= (i + 1);
        i = (i + 1) % num_people;
    }

    return result;
}