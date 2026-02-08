var maxDiff = function(num) {
    let s = num.toString();
    let max = -Infinity;
    let min = Infinity;

    for (let i = 0; i < 10; i++) {
        for (let j = 0; j < 10; j++) {
            let newS = s.replace(new RegExp(i, 'g'), j);
            if (newS[0] === '0') continue;
            let newNum = parseInt(newS, 10);
            if (newNum > max) max = newNum;
            if (newNum < min) min = newNum;
        }
    }

    return max - min;
};