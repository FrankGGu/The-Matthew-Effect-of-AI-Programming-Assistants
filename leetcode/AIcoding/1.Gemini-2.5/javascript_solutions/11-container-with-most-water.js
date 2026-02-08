var maxArea = function(height) {
    let maxArea = 0;
    let left = 0;
    let right = height.length - 1;

    while (left < right) {
        const currentHeight = Math.min(height[left], height[right]);
        const currentWidth = right - left;
        maxArea = Math.max(maxArea, currentHeight * currentWidth);

        if (height[left] < height[right]) {
            left++;
        } else {
            right--;
        }
    }

    return maxArea;
};