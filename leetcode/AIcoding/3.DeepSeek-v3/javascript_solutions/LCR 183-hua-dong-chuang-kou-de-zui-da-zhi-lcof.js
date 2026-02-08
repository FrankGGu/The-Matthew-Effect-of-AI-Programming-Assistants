var maxSlidingWindow = function(heights, k) {
    const result = [];
    const deque = [];

    for (let i = 0; i < heights.length; i++) {
        while (deque.length && heights[i] >= heights[deque[deque.length - 1]]) {
            deque.pop();
        }
        deque.push(i);

        if (deque[0] <= i - k) {
            deque.shift();
        }

        if (i >= k - 1) {
            result.push(heights[deque[0]]);
        }
    }

    return result;
};