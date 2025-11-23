var getKth = function(lo, hi, k) {
    const powerValues = [];
    for (let i = lo; i <= hi; i++) {
        let num = i;
        let power = 0;
        while (num !== 1) {
            if (num % 2 === 0) {
                num = num / 2;
            } else {
                num = 3 * num + 1;
            }
            power++;
        }
        powerValues.push({ num: i, power: power });
    }

    powerValues.sort((a, b) => {
        if (a.power === b.power) {
            return a.num - b.num;
        }
        return a.power - b.power;
    });

    return powerValues[k - 1].num;
};