/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int val;
    int idx;
} Element;

int* secondGreaterElement(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    Element* stack1 = (Element*)malloc(numsSize * sizeof(Element));
    Element* stack2 = (Element*)malloc(numsSize * sizeof(Element));
    Element* temp = (Element*)malloc(numsSize * sizeof(Element));

    int top1 = -1, top2 = -1, tempTop = -1;

    for (int i = 0; i < numsSize; i++) {
        while (top2 != -1 && stack2[top2].val < nums[i]) {
            result[stack2[top2].idx] = nums[i];
            top2--;
        }

        tempTop = -1;
        while (top1 != -1 && stack1[top1].val < nums[i]) {
            temp[++tempTop] = stack1[top1];
            top1--;
        }

        while (tempTop >= 0) {
            stack2[++top2] = temp[tempTop--];
        }

        stack1[++top1] = (Element){nums[i], i};
    }

    free(stack1);
    free(stack2);
    free(temp);

    return result;
}