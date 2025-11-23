int numOfPairs(char **nums, int numsSize, char *target) {
    int count = 0;
    int targetLen = strlen(target);

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                char *concat = malloc(strlen(nums[i]) + strlen(nums[j]) + 1);
                strcpy(concat, nums[i]);
                strcat(concat, nums[j]);
                if (strcmp(concat, target) == 0) {
                    count++;
                }
                free(concat);
            }
        }
    }

    return count;
}