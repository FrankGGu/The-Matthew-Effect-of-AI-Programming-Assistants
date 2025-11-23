var minCut = function(bamboo) {
    let sum = 0;
    for (let i = 0; i < bamboo.length; i++) {
        sum += bamboo[i];
    }

    let ans = 0;
    for (let i = 0; i < bamboo.length; i++) {
        ans += Math.ceil(Math.sqrt(bamboo[i]));
    }

    if (ans >= sum) {
        return bamboo.length;
    } else {
        return bamboo.length - 1;
    }
};