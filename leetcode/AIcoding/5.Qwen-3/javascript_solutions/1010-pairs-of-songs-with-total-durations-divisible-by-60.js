function numPairsDivisibleBy60(time) {
    const count = new Array(60).fill(0);
    let result = 0;

    for (let t of time) {
        const rem = t % 60;
        if (rem === 0) {
            result += count[0];
        } else {
            result += count[60 - rem];
        }
        count[rem]++;
    }

    return result;
}