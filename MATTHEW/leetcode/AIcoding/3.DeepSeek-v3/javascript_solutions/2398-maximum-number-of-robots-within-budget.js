var maximumRobots = function(chargeTimes, runningCosts, budget) {
    let left = 0;
    let currentSum = 0;
    let maxLen = 0;
    const deque = [];

    for (let right = 0; right < chargeTimes.length; right++) {
        currentSum += runningCosts[right];

        while (deque.length && chargeTimes[deque[deque.length - 1]] <= chargeTimes[right]) {
            deque.pop();
        }
        deque.push(right);

        while (deque.length && chargeTimes[deque[0]] + (right - left + 1) * currentSum > budget) {
            if (deque[0] === left) {
                deque.shift();
            }
            currentSum -= runningCosts[left];
            left++;
        }

        if (chargeTimes[deque[0]] + (right - left + 1) * currentSum <= budget) {
            maxLen = Math.max(maxLen, right - left + 1);
        }
    }

    return maxLen;
};