int[] alternatingGroups(int[] nums) {
    int n = sizeof(nums) / sizeof(nums[0]);
    int* result = (int*)malloc(n * sizeof(int));
    int index = 0;

    for(int i = 0; i < n; i++) {
        if(i % 2 == 0) {
            result[index++] = nums[i];
        }
    }

    for(int i = 0; i < n; i++) {
        if(i % 2 != 0) {
            result[index++] = nums[i];
        }
    }

    return result;
}