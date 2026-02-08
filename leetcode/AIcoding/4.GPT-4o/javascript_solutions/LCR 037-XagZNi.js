function asteroidCollision(asteroids) {
    const stack = [];
    for (const asteroid of asteroids) {
        let alive = true;
        while (alive && asteroid < 0 && stack.length && stack[stack.length - 1] > 0) {
            if (stack[stack.length - 1] < -asteroid) {
                stack.pop();
            } else {
                if (stack[stack.length - 1] === -asteroid) stack.pop();
                alive = false;
            }
        }
        if (alive) stack.push(asteroid);
    }
    return stack;
}