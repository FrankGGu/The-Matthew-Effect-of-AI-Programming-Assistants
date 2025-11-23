var asteroidCollision = function(asteroids) {
    const stack = [];
    for (const asteroid of asteroids) {
        if (asteroid > 0) {
            stack.push(asteroid);
        } else {
            while (stack.length > 0 && stack[stack.length - 1] > 0 && stack[stack.length - 1] < -asteroid) {
                stack.pop();
            }
            if (stack.length === 0 || stack[stack.length - 1] < 0) {
                stack.push(asteroid);
            } else if (stack[stack.length - 1] === -asteroid) {
                stack.pop();
            }
        }
    }
    return stack;
};