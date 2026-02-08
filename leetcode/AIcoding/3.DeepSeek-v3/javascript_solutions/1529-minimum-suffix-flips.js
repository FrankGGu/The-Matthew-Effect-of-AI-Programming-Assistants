var minFlips = function(target) {
    let flips = 0;
    let current = '0';
    for (let i = 0; i < target.length; i++) {
        if (target[i] !== current) {
            flips++;
            current = target[i];
        }
    }
    return flips;
};