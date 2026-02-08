var countTime = function(time) {
    let count = 0;

    const matchChar = (patternChar, digitChar) => {
        return patternChar === '?' || patternChar === digitChar;
    };

    for (let h = 0; h < 24; h++) {
        const h0 = Math.floor(h / 10).toString();
        const h1 = (h % 10).toString();

        if (matchChar(time[0], h0) && matchChar(time[1], h1)) {
            for (let m = 0; m < 60; m++) {
                const m0 = Math.floor(m / 10).toString();
                const m1 = (m % 10).toString();

                if (matchChar(time[3], m0) && matchChar(time[4], m1)) {
                    count++;
                }
            }
        }
    }

    return count;
};