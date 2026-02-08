var numOfBurgers = function(tomatoSlices, cheeseSlices) {
    if (tomatoSlices % 2 !== 0 || tomatoSlices / 2 > cheeseSlices) return [];
    let x = (tomatoSlices / 2) - cheeseSlices;
    let y = cheeseSlices - x;
    if (x < 0 || y < 0) return [];
    return [x, y];
};