var asteroidCollision = function(asteroids) {
    const stack = [];
    for (const asteroid of asteroids) {
        let alive = true;
        while (alive && asteroid < 0 && stack.length && stack[stack.length - 1] > 0) {
            const top = stack.pop();
            if (top < -asteroid) {
                asteroid = 0;
                stack.push(top);
            } else if (top === -asteroid) {
                asteroid = 0;
            }
        }
        if (asteroid !== 0) {
            stack.push(asteroid);
        }
    }
    return stack;
};