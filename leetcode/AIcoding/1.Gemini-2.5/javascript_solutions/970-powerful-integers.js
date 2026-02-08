var powerfulIntegers = function(x, y, bound) {
    const powerfulIntegersSet = new Set();

    let val1 = 1;
    while (val1 <= bound) {
        let val2 = 1;
        while (val1 + val2 <= bound) {
            powerfulIntegersSet.add(val1 + val2);

            if (y === 1) {
                break; 
            }
            val2 *= y;
        }

        if (x === 1) {
            break;
        }
        val1 *= x;
    }

    return Array.from(powerfulIntegersSet);
};