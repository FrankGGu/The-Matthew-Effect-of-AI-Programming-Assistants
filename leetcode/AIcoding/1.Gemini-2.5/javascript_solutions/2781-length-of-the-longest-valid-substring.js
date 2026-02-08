var longestValidParentheses = function(s) {
    let maxLen = 0;
    const stack = [-1]; // Initialize stack with -1 to handle base cases

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            stack.push(i);
        } else { // s[i] === ')'
            stack.pop();
            if (stack.length === 0) {
                // If stack is empty, it means the current ')' doesn't have a matching '('
                // or it closes a sequence that started before the last unmatched '('.
                // Push current index to mark a new potential start of an invalid sequence.
                stack.push(i);
            } else {
                // If stack is not empty, we found a valid pair.
                // The length is current_index - stack.top().
                maxLen = Math.max(maxLen, i - stack[stack.length - 1]);
            }
        }
    }

    return maxLen;
};