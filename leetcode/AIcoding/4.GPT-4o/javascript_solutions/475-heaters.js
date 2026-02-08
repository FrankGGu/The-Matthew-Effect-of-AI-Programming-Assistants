var findRadius = function(houses, heaters) {
    houses.sort((a, b) => a - b);
    heaters.sort((a, b) => a - b);
    let radius = 0, j = 0;

    for (const house of houses) {
        while (j < heaters.length - 1 && 
               Math.abs(heaters[j] - house) >= Math.abs(heaters[j + 1] - house)) {
            j++;
        }
        radius = Math.max(radius, Math.abs(heaters[j] - house));
    }

    return radius;
};