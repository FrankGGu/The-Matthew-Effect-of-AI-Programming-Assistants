function minFlips(data) {
    const n = data.length, m = data[0].length;
    let flips = 0;

    for (let i = 0; i < Math.floor(n / 2); i++) {
        for (let j = 0; j < Math.floor(m / 2); j++) {
            const count = data[i][j] + data[i][m - 1 - j] + data[n - 1 - i][j] + data[n - 1 - i][m - 1 - j];
            flips += Math.min(count, 4 - count);
        }
    }

    if (n % 2 === 1) {
        for (let j = 0; j < Math.floor(m / 2); j++) {
            flips += data[Math.floor(n / 2)][j] ^ data[Math.floor(n / 2)][m - 1 - j];
        }
    }

    if (m % 2 === 1) {
        for (let i = 0; i < Math.floor(n / 2); i++) {
            flips += data[i][Math.floor(m / 2)] ^ data[n - 1 - i][Math.floor(m / 2)];
        }
    }

    return flips;
}