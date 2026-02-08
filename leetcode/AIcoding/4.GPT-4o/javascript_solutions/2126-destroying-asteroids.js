function asteroidCollision(asteroids) {
    const stack = [];

    for (const asteroid of asteroids) {
        let alive = true;

        while (alive && asteroid < 0 && stack.length > 0 && stack[stack.length - 1] > 0) {
            const top = stack.pop();
            if (top === -asteroid) {
                alive = false;
            } else if (top > -asteroid) {
                stack.push(top);
                alive = false;
            }
        }

        if (alive) {
            stack.push(asteroid);
        }
    }

    return stack;
}