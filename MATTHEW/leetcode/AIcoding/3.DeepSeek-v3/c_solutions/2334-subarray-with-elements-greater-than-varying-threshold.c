typedef struct {
    int start;
    int height;
} Element;

int validSubarraySize(int* nums, int numsSize, int threshold) {
    Element* stack = (Element*)malloc((numsSize + 1) * sizeof(Element));
    int top = -1;

    stack[++top] = (Element){-1, 0};

    for (int i = 0; i <= numsSize; i++) {
        int current = (i < numsSize) ? nums[i] : 0;

        while (top > 0 && stack[top].height > current) {
            Element popped = stack[top--];
            int width = i - stack[top].start - 1;
            if (popped.height > threshold / width) {
                free(stack);
                return width;
            }
        }

        stack[++top] = (Element){i, current};
    }

    free(stack);
    return -1;
}