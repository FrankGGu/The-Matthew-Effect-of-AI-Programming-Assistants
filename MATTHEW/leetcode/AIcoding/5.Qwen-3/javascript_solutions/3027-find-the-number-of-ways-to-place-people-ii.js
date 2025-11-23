function numberOfWaysPeopleYouCanSee(heights) {
    const n = heights.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && heights[stack[stack.length - 1]] < heights[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? 0 : stack.length;
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && heights[stack[stack.length - 1]] < heights[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? 0 : stack.length;
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result += left[i] * right[i];
    }

    return result;
}