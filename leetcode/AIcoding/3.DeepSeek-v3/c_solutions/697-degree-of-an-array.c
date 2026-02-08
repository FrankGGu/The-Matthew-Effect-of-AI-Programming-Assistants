typedef struct {
    int count;
    int first;
    int last;
} ElementInfo;

int findShortestSubArray(int* nums, int numsSize) {
    ElementInfo* map = (ElementInfo*)calloc(50000, sizeof(ElementInfo));
    int maxCount = 0;
    int minLength = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (map[num].count == 0) {
            map[num].first = i;
        }
        map[num].last = i;
        map[num].count++;

        if (map[num].count > maxCount) {
            maxCount = map[num].count;
            minLength = map[num].last - map[num].first + 1;
        } else if (map[num].count == maxCount) {
            int length = map[num].last - map[num].first + 1;
            if (length < minLength) {
                minLength = length;
            }
        }
    }

    free(map);
    return minLength;
}