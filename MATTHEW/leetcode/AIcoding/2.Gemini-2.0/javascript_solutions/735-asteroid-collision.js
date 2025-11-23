var asteroidCollision = function(asteroids) {
    const stack = [];
    for (const asteroid of asteroids) {
        let alive = true;
        while (alive && asteroid < 0 && stack.length > 0 && stack[stack.length - 1] > 0) {
            const top = stack[stack.length - 1];
            if (Math.abs(asteroid) > top) {
                stack.pop();
            } else if (Math.abs(asteroid) === top) {
                stack.pop();
                alive = false;
            } else {
                alive = false;
            }
        }
        if (alive) {
            stack.push(asteroid);
        }
    }
    return stack;
};