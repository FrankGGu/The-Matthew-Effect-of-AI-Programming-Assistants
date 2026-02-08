var magicalString = function(n) {
    if (n <= 0) {
        return 0;
    }
    if (n <= 3) {
        return 1;
    }

    const s = new Array(n);
    s[0] = 1;
    s[1] = 2;
    s[2] = 2;

    let head = 2;
    let tail = 3;
    let oneCount = 1;

    while (tail < n) {
        const charToRepeat = (s[tail - 1] === 1) ? 2 : 1;
        const repetitions = s[head];

        for (let i = 0; i < repetitions; i++) {
            if (tail < n) {
                s[tail] = charToRepeat;
                if (charToRepeat === 1) {
                    oneCount++;
                }
                tail++;
            } else {
                break;
            }
        }
        head++;
    }

    return oneCount;
};