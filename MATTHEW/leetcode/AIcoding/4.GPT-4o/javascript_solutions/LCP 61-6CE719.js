var dailyTemperatures = function(T) {
    const result = new Array(T.length).fill(0);
    const stack = [];

    for (let i = 0; i < T.length; i++) {
        while (stack.length && T[i] > T[stack[stack.length - 1]]) {
            const index = stack.pop();
            result[index] = i - index;
        }
        stack.push(i);
    }

    return result;
};