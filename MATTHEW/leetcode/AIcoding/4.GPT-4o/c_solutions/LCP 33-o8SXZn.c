int trap(int* height, int heightSize) {
    if (heightSize <= 2) return 0;
    int left = 0, right = heightSize - 1;
    int leftMax = height[left], rightMax = height[right];
    int waterTrapped = 0;

    while (left < right) {
        if (height[left] < height[right]) {
            left++;
            leftMax = leftMax > height[left] ? leftMax : height[left];
            waterTrapped += leftMax - height[left];
        } else {
            right--;
            rightMax = rightMax > height[right] ? rightMax : height[right];
            waterTrapped += rightMax - height[right];
        }
    }

    return waterTrapped;
}