var removeBubbles = function(bubbles) {
    const stack = [];

    for (const bubble of bubbles) {
        if (stack.length === 0 || stack[stack.length - 1].color !== bubble) {
            stack.push({ color: bubble, count: 1 });
        } else {
            stack[stack.length - 1].count++;
        }

        if (stack.length > 0 && stack[stack.length - 1].count >= 3) {
            stack.pop();
        }
    }

    const result = [];
    for (const item of stack) {
        for (let i = 0; i < item.count; i++) {
            result.push(item.color);
        }
    }

    return result;
};