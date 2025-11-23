var findRadius = function(houses, heaters) {
    houses.sort((a, b) => a - b);
    heaters.sort((a, b) => a - b);

    let result = 0;
    let i = 0;

    for (const house of houses) {
        while (i < heaters.length - 1 && Math.abs(heaters[i + 1] - house) <= Math.abs(heaters[i] - house)) {
            i++;
        }
        result = Math.max(result, Math.abs(heaters[i] - house));
    }

    return result;
};