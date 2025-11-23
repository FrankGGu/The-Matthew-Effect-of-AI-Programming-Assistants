/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* distributeCandies(int candies, int num_people, int* returnSize) {
    *returnSize = num_people;
    int* result = (int*)calloc(num_people, sizeof(int));
    int give = 0;
    int i = 0;

    while (candies > 0) {
        give++;
        int actual_give = (give < candies) ? give : candies;
        result[i % num_people] += actual_give;
        candies -= actual_give;
        i++;
    }

    return result;
}