var canSeePersonsCount = function(heights) {
    const result = [];
    const stack = [];

    for (let i = heights.length - 1; i >= 0; i--) {
        let count = 0;
        while (stack.length && stack[stack.length - 1] < heights[i]) {
            count++;
            stack.pop();
        }
        if (stack.length) count++;
        result[i] = count;
        stack.push(heights[i]);
    }

    return result;
};