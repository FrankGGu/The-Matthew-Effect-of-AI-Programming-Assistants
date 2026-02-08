function maxContainers(heights) {
    let left = 0, right = heights.length - 1;
    let maxContainers = 0;

    while (left < right) {
        const minHeight = Math.min(heights[left], heights[right]);
        const width = right - left;
        maxContainers = Math.max(maxContainers, minHeight * width);

        if (heights[left] < heights[right]) {
            left++;
        } else {
            right--;
        }
    }

    return maxContainers;
}