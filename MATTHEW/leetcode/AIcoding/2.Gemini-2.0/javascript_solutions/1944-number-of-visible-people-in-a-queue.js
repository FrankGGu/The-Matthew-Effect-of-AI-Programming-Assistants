var canSeePersonsCount = function(heights) {
    const n = heights.length;
    const result = new Array(n).fill(0);
    const stack = [];

    for (let i = n - 1; i >= 0; i--) {
        let count = 0;
        while (stack.length > 0 && heights[i] > heights[stack[stack.length - 1]]) {
            stack.pop();
            count++;
        }

        if (stack.length > 0) {
            count++;
        }

        result[i] = count;
        stack.push(i);
    }

    return result;
};