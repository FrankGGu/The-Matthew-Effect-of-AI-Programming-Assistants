function isRationalEqual(s, t) {
    function parse(s) {
        let i = 0;
        let num = 0;
        let dec = 0;
        let repeat = false;
        let decimalPart = '';
        let nonRepeat = '';
        let repeatPart = '';
        while (i < s.length && s[i] !== '(') {
            if (s[i] === '.') {
                i++;
                continue;
            }
            num = num * 10 + parseInt(s[i]);
            i++;
        }
        if (i < s.length && s[i] === '(') {
            i++;
            while (i < s.length && s[i] !== ')') {
                decimalPart += s[i];
                i++;
            }
            i++;
            let j = 0;
            while (j < decimalPart.length) {
                if (decimalPart[j] === '.') {
                    j++;
                    continue;
                }
                if (!repeat) {
                    nonRepeat += decimalPart[j];
                } else {
                    repeatPart += decimalPart[j];
                }
                j++;
            }
            repeat = true;
        } else {
            while (i < s.length && s[i] !== '.') {
                i++;
            }
            while (i < s.length) {
                decimalPart += s[i];
                i++;
            }
        }
        if (nonRepeat !== '') {
            num = num * Math.pow(10, nonRepeat.length);
            num += parseInt(nonRepeat);
        }
        if (repeatPart !== '') {
            let len = repeatPart.length;
            let numerator = num * Math.pow(10, len) + parseInt(repeatPart) - num;
            let denominator = Math.pow(10, len) - 1;
            return [numerator, denominator];
        } else {
            return [num, 1];
        }
    }

    let [aNum, aDen] = parse(s);
    let [bNum, bDen] = parse(t);

    return aNum * bDen === bNum * aDen;
}