function longestHappyString(a, b, c) {
    const map = new Map();
    map.set('a', a);
    map.set('b', b);
    map.set('c', c);

    let res = [];
    let prevChar = '';

    while (true) {
        let maxCount = 0;
        let maxChar = '';

        for (const [char, count] of map.entries()) {
            if (count > 0 && char !== prevChar) {
                if (count > maxCount) {
                    maxCount = count;
                    maxChar = char;
                }
            }
        }

        if (maxChar === '') break;

        res.push(maxChar);
        map.set(maxChar, map.get(maxChar) - 1);
        prevChar = maxChar;

        if (res.length >= 2 && res[res.length - 1] === res[res.length - 2]) {
            let secondMaxCount = 0;
            let secondMaxChar = '';

            for (const [char, count] of map.entries()) {
                if (count > 0 && char !== prevChar) {
                    if (count > secondMaxCount) {
                        secondMaxCount = count;
                        secondMaxChar = char;
                    }
                }
            }

            if (secondMaxChar === '') break;

            res.push(secondMaxChar);
            map.set(secondMaxChar, map.get(secondMaxChar) - 1);
            prevChar = secondMaxChar;
        }
    }

    return res.join('');
}