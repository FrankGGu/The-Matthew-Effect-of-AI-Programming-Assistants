var defendCity = function(height) {
    let n = height.length;
    let ans = 0;
    let left = 0;
    for (let right = 1; right < n; right++) {
        if (height[right] >= height[right - 1]) {
            let minHeight = Math.min(height[left], height[right]);
            let area = 0;
            for (let i = left + 1; i < right; i++) {
                area += Math.max(0, minHeight - height[i]);
            }
            ans += area;
            left = right;
        } else if (height[right] < height[right - 1] && height[right] >= height[left]) {

        } else if(height[right] < height[left]){

        }
    }
    return ans;
};