bool canChoose(int** groups, int groupsSize, int* groupsColSize, int* nums, int numsSize) {
    int i = 0, j = 0;
    while (i < groupsSize && j < numsSize) {
        if (nums[j] == groups[i][0]) {
            int k = 0;
            while (k < groupsColSize[i] && j + k < numsSize && nums[j + k] == groups[i][k]) {
                k++;
            }
            if (k == groupsColSize[i]) {
                j += k;
                i++;
            } else {
                j++;
            }
        } else {
            j++;
        }
    }
    return i == groupsSize;
}