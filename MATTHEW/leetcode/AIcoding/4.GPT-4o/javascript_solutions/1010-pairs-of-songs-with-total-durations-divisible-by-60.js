var numPairsDivisibleBy60 = function(time) {
    let count = 0;
    const remainderCount = new Array(60).fill(0);

    for (let t of time) {
        const remainder = t % 60;
        const complement = (60 - remainder) % 60;
        count += remainderCount[complement];
        remainderCount[remainder]++;
    }

    return count;
};