var largestRectangleArea = function(heights) {
    let n = heights.length;
    let stack = [];
    let maxArea = 0;

    for (let i = 0; i <= n; i++) {
        let height = (i === n) ? 0 : heights[i];

        while (stack.length > 0 && height < heights[stack[stack.length - 1]]) {
            let top = stack.pop();
            let area = heights[top] * (stack.length === 0 ? i : i - stack[stack.length - 1] - 1);
            maxArea = Math.max(maxArea, area);
        }
        stack.push(i);
    }

    return maxArea;
};