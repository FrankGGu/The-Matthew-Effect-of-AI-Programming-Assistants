var asteroidCollision = function(asteroids) {
    const stack = [];

    for (const asteroid of asteroids) {
        if (asteroid > 0) {
            stack.push(asteroid);
        } else {
            let collision = false;
            while (stack.length > 0 && stack[stack.length - 1] > 0) {
                const top = stack[stack.length - 1];
                if (Math.abs(asteroid) > top) {
                    stack.pop(); // Positive asteroid destroyed
                } else if (Math.abs(asteroid) === top) {
                    stack.pop(); // Both destroyed
                    collision = true;
                    break;
                } else { // Math.abs(asteroid) < top
                    collision = true; // Current negative asteroid destroyed
                    break;
                }
            }
            if (!collision) {
                stack.push(asteroid);
            }
        }
    }

    return stack;
};