function numRabbits(bunnies) {
    const count = {};
    let total = 0;
    for (const color of bunnies) {
        if (count[color] === undefined) {
            count[color] = 1;
        } else {
            count[color]++;
        }
        if (count[color] === 1) {
            total += 1;
        } else if (count[color] % (bunnies[count[color] - 1] + 1) === 0) {
            total += 1;
        }
    }
    return total;
}