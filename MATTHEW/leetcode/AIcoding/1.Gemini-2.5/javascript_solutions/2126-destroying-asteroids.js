var asteroidsDestroyed = function(mass, asteroids) {
    asteroids.sort((a, b) => a - b);

    let currentMass = mass;

    for (let i = 0; i < asteroids.length; i++) {
        if (currentMass >= asteroids[i]) {
            currentMass += asteroids[i];
        } else {
            return false;
        }
    }

    return true;
};