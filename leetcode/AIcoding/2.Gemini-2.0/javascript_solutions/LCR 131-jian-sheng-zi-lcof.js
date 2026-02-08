var minCut = function(bamboo) {
    let sum = 0;
    let count = 0;
    for (let len of bamboo) {
        sum += len;
    }

    let avg = sum / bamboo.length;

    for (let len of bamboo) {
        count += Math.ceil(len / avg) - 1;
    }

    return count;
};