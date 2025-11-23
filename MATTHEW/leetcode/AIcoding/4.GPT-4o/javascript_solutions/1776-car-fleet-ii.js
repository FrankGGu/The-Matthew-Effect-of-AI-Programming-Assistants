function carFleet(target, position, speed) {
    const n = position.length;
    const cars = [];

    for (let i = 0; i < n; i++) {
        cars.push([position[i], speed[i]]);
    }

    cars.sort((a, b) => b[0] - a[0]);

    let fleets = 0;
    let timeToReach = 0;

    for (let i = 0; i < n; i++) {
        const [pos, spd] = cars[i];
        const time = (target - pos) / spd;

        if (time > timeToReach) {
            fleets++;
            timeToReach = time;
        }
    }

    return fleets;
}