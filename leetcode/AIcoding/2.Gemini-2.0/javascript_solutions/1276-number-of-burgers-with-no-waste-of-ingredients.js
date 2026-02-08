var numOfBurgers = function(tomatoSlices, cheeseSlices) {
    let jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
    let small = cheeseSlices - jumbo;

    if (jumbo >= 0 && small >= 0 && jumbo % 1 === 0 && small % 1 === 0) {
        return [jumbo, small];
    } else {
        return [];
    }
};