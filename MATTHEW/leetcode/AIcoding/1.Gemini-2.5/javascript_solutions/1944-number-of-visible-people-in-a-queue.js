var canSeePersonsCount = function(heights) {
    const n = heights.length;
    const ans = new Array(n).fill(0);
    const stack = []; // Stores indices of people, forming a decreasing monotonic stack of heights

    // Iterate from right to left
    for (let i = n - 1; i >= 0; i--) {
        // While the stack is not empty and the person at the top of the stack
        // is shorter than the current person (heights[i]):
        // The current person can see the person on top of the stack.
        // The person on top of the stack is then "removed" because they are blocked
        // by the current person (heights[i]) from anyone further to the left.
        while (stack.length > 0 && heights[stack[stack.length - 1]] < heights[i]) {
            ans[i]++;
            stack.pop();
        }

        // If the stack is not empty after popping, it means the person at the top
        // of the stack is taller than or equal to heights[i].
        // The current person can see this person.
        // This person then blocks the view of anyone further to the right from heights[i].
        if (stack.length > 0) {
            ans[i]++;
        }

        // Push the current person's index onto the stack.
        // The stack maintains a decreasing order of heights from bottom to top.
        stack.push(i);
    }

    return ans;
};