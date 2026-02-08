var carFleet = function(target, position, speed) {
    const cars = position.map((p, i) => [p, speed[i]]).sort((a, b) => a[0] - b[0]);
    let fleets = 0;
    let time = 0;

    for (let i = cars.length - 1; i >= 0; i--) {
        const [p, s] = cars[i];
        const t = (target - p) / s;
        if (t > time) {
            time = t;
            fleets++;
        }
    }

    return fleets;
};