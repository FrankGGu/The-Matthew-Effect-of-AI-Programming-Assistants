var canSeePersonsCount = function(heights) {
    const stack = [];
    const result = new Array(heights.length).fill(0);

    for (let i = heights.length - 1; i >= 0; i--) {
        let count = 0;
        while (stack.length > 0 && heights[i] > stack[stack.length - 1]) {
            stack.pop();
            count++;
        }
        if (stack.length > 0) {
            count++;
        }
        result[i] = count;
        stack.push(heights[i]);
    }

    return result;
};