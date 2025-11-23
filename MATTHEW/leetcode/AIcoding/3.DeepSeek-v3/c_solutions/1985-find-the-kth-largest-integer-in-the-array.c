int compare(const void* a, const void* b) {
    char* num1 = *(char**)a;
    char* num2 = *(char**)b;
    int len1 = strlen(num1);
    int len2 = strlen(num2);

    if (len1 != len2) {
        return len2 - len1;
    }

    return strcmp(num2, num1);
}

char* kthLargestNumber(char** nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(char*), compare);
    return nums[k-1];
}