var numPairsDivisibleBy60 = function(time) {
    let count = 0;
    const remainders = new Array(60).fill(0);

    for (let t of time) {
        const remainder = t % 60;
        count += remainders[(60 - remainder) % 60];
        remainders[remainder]++;
    }

    return count;
};