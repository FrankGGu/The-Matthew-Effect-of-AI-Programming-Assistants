var asteroidCollision = function(asteroids) {
    const stack = [];

    for (const asteroid of asteroids) {
        if (asteroid > 0) {
            stack.push(asteroid);
        } else { // asteroid < 0
            let currentAsteroidDestroyed = false;
            while (stack.length > 0 && stack[stack.length - 1] > 0) {
                const topAsteroid = stack[stack.length - 1];
                if (Math.abs(asteroid) > topAsteroid) {
                    stack.pop(); // Top asteroid explodes
                    // currentAsteroid continues to collide with the next
                } else if (Math.abs(asteroid) === topAsteroid) {
                    stack.pop(); // Both explode
                    currentAsteroidDestroyed = true;
                    break; // Current asteroid is destroyed
                } else { // Math.abs(asteroid) < topAsteroid
                    currentAsteroidDestroyed = true; // Current asteroid explodes
                    break; // Current asteroid is destroyed
                }
            }
            if (!currentAsteroidDestroyed) {
                stack.push(asteroid);
            }
        }
    }

    return stack;
};