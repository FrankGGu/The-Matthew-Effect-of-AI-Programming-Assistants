var carFleet = function(target, position, speed) {
    if (position.length === 0) {
        return 0;
    }

    const cars = [];
    for (let i = 0; i < position.length; i++) {
        cars.push({ pos: position[i], spd: speed[i] });
    }

    cars.sort((a, b) => b.pos - a.pos);

    let fleets = 0;
    let maxTime = 0;

    for (let i = 0; i < cars.length; i++) {
        const timeToTarget = (target - cars[i].pos) / cars[i].spd;

        if (timeToTarget > maxTime) {
            fleets++;
            maxTime = timeToTarget;
        }
    }

    return fleets;
};