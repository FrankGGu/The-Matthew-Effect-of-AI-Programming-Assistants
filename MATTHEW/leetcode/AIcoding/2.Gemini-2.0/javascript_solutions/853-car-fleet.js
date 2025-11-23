var carFleet = function(target, position, speed) {
    const cars = [];
    for (let i = 0; i < position.length; i++) {
        cars.push([position[i], speed[i]]);
    }

    cars.sort((a, b) => a[0] - b[0]);

    const times = [];
    for (let i = 0; i < cars.length; i++) {
        times.push((target - cars[i][0]) / cars[i][1]);
    }

    let fleets = 0;
    let maxTime = 0;
    for (let i = times.length - 1; i >= 0; i--) {
        if (times[i] > maxTime) {
            fleets++;
            maxTime = times[i];
        }
    }

    return fleets;
};