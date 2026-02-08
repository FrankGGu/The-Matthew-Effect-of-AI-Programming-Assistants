var readBinaryWatch = function(turnedOn) {
    const result = [];

    const countSetBits = (num) => {
        let count = 0;
        while (num > 0) {
            count += (num & 1);
            num >>= 1;
        }
        return count;
    };

    for (let h = 0; h < 12; h++) {
        for (let m = 0; m < 60; m++) {
            if (countSetBits(h) + countSetBits(m) === turnedOn) {
                const minuteStr = m < 10 ? '0' + m : String(m);
                result.push(`${h}:${minuteStr}`);
            }
        }
    }

    return result;
};