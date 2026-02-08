var asteroidCollision = function(asteroids) {
    let stack = [];
    for (let asteroid of asteroids) {
        if (asteroid > 0) {
            stack.push(asteroid);
        } else {
            while (stack.length > 0 && stack[stack.length - 1] > 0 && stack[stack.length - 1] < Math.abs(asteroid)) {
                stack.pop();
            }
            if (stack.length === 0 || stack[stack.length - 1] < 0) {
                stack.push(asteroid);
            } else if (stack[stack.length - 1] === Math.abs(asteroid)) {
                stack.pop();
            }
        }
    }
    return stack;
};