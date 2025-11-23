var maxWidthRamp = function(A) {
    let n = A.length;
    let maxWidth = 0;
    let stack = [];

    for (let i = 0; i < n; i++) {
        if (stack.length === 0 || A[stack[stack.length - 1]] > A[i]) {
            stack.push(i);
        }
    }

    for (let j = n - 1; j >= 0; j--) {
        while (stack.length > 0 && A[stack[stack.length - 1]] <= A[j]) {
            maxWidth = Math.max(maxWidth, j - stack.pop());
        }
    }

    return maxWidth;
};