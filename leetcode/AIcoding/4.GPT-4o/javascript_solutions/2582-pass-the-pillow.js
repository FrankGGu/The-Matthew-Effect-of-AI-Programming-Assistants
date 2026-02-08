function passThePillow(n, time) {
    let position = 1;
    let direction = 1;

    for (let i = 0; i < time; i++) {
        position += direction;
        if (position === 1 || position === n) {
            direction *= -1;
        }
    }

    return position;
}