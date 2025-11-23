var maxArea = function(height) {
    let maxarea = 0;
    let left = 0;
    let right = height.length - 1;

    while (left < right) {
        const width = right - left;
        const minHeight = Math.min(height[left], height[right]);
        const area = width * minHeight;
        maxarea = Math.max(maxarea, area);

        if (height[left] <= height[right]) {
            left++;
        } else {
            right--;
        }
    }

    return maxarea;
};