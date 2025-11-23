var maximumRobots = function(chargeTimes, runningCosts, budget) {
    const n = chargeTimes.length;
    let left = 0;
    let currentRunningCostSum = 0;
    let maxRobots = 0;

    // Deque to store indices of chargeTimes in decreasing order of their values.
    // The front of the deque will always hold the index of the maximum chargeTime in the current window.
    const chargeTimeDeque = []; 

    for (let right = 0; right < n; right++) {
        currentRunningCostSum += runningCosts[right];

        // Maintain the deque for chargeTimes (monotonic decreasing)
        // Remove elements from the back that are less than or equal to the new element
        while (chargeTimeDeque.length > 0 && chargeTimes[chargeTimeDeque[chargeTimeDeque.length - 1]] <= chargeTimes[right]) {
            chargeTimeDeque.pop();
        }
        // Add the current element's index to the back of the deque
        chargeTimeDeque.push(right);

        // Shrink the window from the left if the budget condition is violated.
        // The condition is: max(chargeTimes) + k * sum(runningCosts) <= budget
        // Here, k = (right - left + 1)
        while (chargeTimeDeque.length > 0 && chargeTimes[chargeTimeDeque[0]] + (right - left + 1) * currentRunningCostSum > budget) {
            // Remove the runningCost of the robot leaving the window
            currentRunningCostSum -= runningCosts[left];

            // If the element at the front of the deque is the one leaving the window, remove it
            if (chargeTimeDeque[0] === left) {
                chargeTimeDeque.shift();
            }
            // Move the left pointer to shrink the window
            left++;
        }

        // After shrinking, the current window [left, right] is valid.
        // Update maxRobots with the current window size.
        maxRobots = Math.max(maxRobots, right - left + 1);
    }

    return maxRobots;
};