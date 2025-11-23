var numOfBurgers = function(tomatoSlices, cheeseSlices) {
    if (tomatoSlices % 2 !== 0) {
        return [];
    }

    // Let j be the number of jumbo burgers and s be the number of small burgers.
    // 4j + 2s = tomatoSlices
    // j + s = cheeseSlices  => s = cheeseSlices - j

    // Substitute s into the first equation:
    // 4j + 2(cheeseSlices - j) = tomatoSlices
    // 4j + 2 * cheeseSlices - 2j = tomatoSlices
    // 2j = tomatoSlices - 2 * cheeseSlices
    // j = (tomatoSlices - 2 * cheeseSlices) / 2

    // Substitute j back into s = cheeseSlices - j:
    // s = cheeseSlices - (tomatoSlices - 2 * cheeseSlices) / 2
    // s = (2 * cheeseSlices - (tomatoSlices - 2 * cheeseSlices)) / 2
    // s = (2 * cheeseSlices - tomatoSlices + 2 * cheeseSlices) / 2
    // s = (4 * cheeseSlices - tomatoSlices) / 2

    const jumboBurgers = (tomatoSlices - 2 * cheeseSlices) / 2;
    const smallBurgers = (4 * cheeseSlices - tomatoSlices) / 2;

    if (jumboBurgers >= 0 && smallBurgers >= 0) {
        return [jumboBurgers, smallBurgers];
    } else {
        return [];
    }
};