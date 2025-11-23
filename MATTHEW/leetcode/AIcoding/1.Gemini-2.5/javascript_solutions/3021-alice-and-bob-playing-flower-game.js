var flowerGame = function(n, m) {
    const odd_n = Math.ceil(n / 2);
    const even_n = Math.floor(n / 2);

    const odd_m = Math.ceil(m / 2);
    const even_m = Math.floor(m / 2);

    return (odd_n * even_m) + (even_n * odd_m);
};