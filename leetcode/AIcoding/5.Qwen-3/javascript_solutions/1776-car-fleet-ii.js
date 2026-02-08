var carFleet = function(target, position, speed) {
    const cars = position.map((p, i) => [p, speed[i]]);
    cars.sort((a, b) => b[0] - a[0]);

    let fleets = 0;
    let time = 0;

    for (const [p, s] of cars) {
        const t = (target - p) / s;
        if (t > time) {
            fleets++;
            time = t;
        }
    }

    return fleets;
};