var carFleet = function(target, position, speed) {
    const cars = position.map((pos, index) => ({ pos, time: (target - pos) / speed[index] }));
    cars.sort((a, b) => b.pos - a.pos);

    let fleets = 0;
    let currentMaxTime = 0;

    for (const car of cars) {
        if (car.time > currentMaxTime) {
            fleets++;
            currentMaxTime = car.time;
        }
    }

    return fleets;
};