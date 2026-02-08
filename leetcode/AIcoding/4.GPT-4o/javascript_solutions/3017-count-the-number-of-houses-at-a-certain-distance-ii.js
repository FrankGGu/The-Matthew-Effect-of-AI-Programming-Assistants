var countHouses = function(houses, d) {
    let count = 0;
    let n = houses.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j && Math.abs(houses[i] - houses[j]) === d) {
                count++;
            }
        }
    }

    return count / 2;
};