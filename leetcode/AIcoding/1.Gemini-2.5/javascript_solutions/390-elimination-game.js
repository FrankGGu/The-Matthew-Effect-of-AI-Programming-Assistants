var lastRemaining = function(n) {
    let head = 1;
    let step = 1;
    let remaining = n;
    let isLeft = true; // true for left-to-right, false for right-to-left

    while (remaining > 1) {
        // The head changes if we are eliminating from left-to-right
        // OR if we are eliminating from right-to-left and the number of remaining elements is odd.
        // In both these cases, the current 'head' element is removed.
        if (isLeft || remaining % 2 === 1) {
            head += step;
        }

        remaining = Math.floor(remaining / 2);
        step *= 2;
        isLeft = !isLeft;
    }

    return head;
};