var asteroidsDestroyed = function(mass, asteroids) {
    asteroids.sort((a, b) => a - b);

    for (let i = 0; i < asteroids.length; i++) {
        if (mass >= asteroids[i]) {
            mass += asteroids[i];
        } else {
            return false;
        }
    }

    return true;
};