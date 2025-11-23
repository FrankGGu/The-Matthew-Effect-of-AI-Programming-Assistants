function numOfBurgers(totalJ, totalS, totalB) {
    const result = [];
    for (let j = 0; j <= totalJ; j++) {
        const s = (totalB - j * 2) / 3;
        if (s === Math.floor(s) && j * 2 + s * 3 === totalB && j + s === totalJ) {
            result.push([j, s]);
        }
    }
    return result;
}