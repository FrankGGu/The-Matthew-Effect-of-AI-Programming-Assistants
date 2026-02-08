var dailyTemperatures = function(temperatures) {
    const n = temperatures.length;
    const answer = new Array(n).fill(0);
    const stack = []; // Stores indices

    for (let i = 0; i < n; i++) {
        const currentTemp = temperatures[i];
        while (stack.length > 0 && temperatures[stack[stack.length - 1]] < currentTemp) {
            const prevIndex = stack.pop();
            answer[prevIndex] = i - prevIndex;
        }
        stack.push(i);
    }

    return answer;
};