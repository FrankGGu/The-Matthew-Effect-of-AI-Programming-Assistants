var maximumRobots = function(chargeTimes, runningCosts, budget) {
    let n = chargeTimes.length;
    let left = 0, right = 0, ans = 0;
    let sum = 0;
    let maxCharge = 0;
    let deque = [];

    while (right < n) {
        sum += runningCosts[right];

        while (deque.length > 0 && chargeTimes[deque[deque.length - 1]] <= chargeTimes[right]) {
            deque.pop();
        }
        deque.push(right);

        maxCharge = chargeTimes[deque[0]];

        while (maxCharge + sum > budget) {
            sum -= runningCosts[left];
            if (deque[0] === left) {
                deque.shift();
            }
            left++;
            if (deque.length > 0) {
                maxCharge = chargeTimes[deque[0]];
            } else {
                maxCharge = 0;
            }
        }

        ans = Math.max(ans, right - left + 1);
        right++;
    }

    return ans;
};