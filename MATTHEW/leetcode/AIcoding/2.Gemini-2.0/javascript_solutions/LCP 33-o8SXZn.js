var storeWater = function(height) {
    let left = 0;
    let right = height.length - 1;
    let area = 0;

    while (left < right) {
        let h = Math.min(height[left], height[right]);
        area = Math.max(area, h * (right - left));

        if (height[left] < height[right]) {
            left++;
        } else {
            right--;
        }
    }

    return area;
};