var asteroidsDestroyed = function(mass, asteroids) {
    asteroids.sort((a, b) => a - b);
    let currentMass = mass;
    for (const asteroid of asteroids) {
        if (currentMass >= asteroid) {
            currentMass += asteroid;
        } else {
            return false;
        }
    }
    return true;
};