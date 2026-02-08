var numPairsDivisibleBy60 = function(time) {
    let remainders = new Array(60).fill(0);
    let count = 0;

    for (let t of time) {
        let remainder = t % 60;
        let targetRemainder = (60 - remainder) % 60;

        count += remainders[targetRemainder];
        remainders[remainder]++;
    }

    return count;
};