var flowerGame = function(n, m) {
    let evenN = Math.floor(n / 2);
    let evenM = Math.floor(m / 2);

    return evenN * m + evenM * n - 2 * evenN * evenM;
};