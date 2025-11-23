function asteroidCollision(asteroids) {
    const stack = [];

    for (const asteroid of asteroids) {
        let collision = false;
        while (stack.length > 0 && stack[stack.length - 1] > 0 && asteroid < 0) {
            const last = stack[stack.length - 1];
            if (last < -asteroid) {
                stack.pop();
            } else if (last === -asteroid) {
                stack.pop();
                collision = true;
                break;
            } else {
                collision = true;
                break;
            }
        }
        if (!collision) {
            stack.push(asteroid);
        }
    }

    return stack;
}