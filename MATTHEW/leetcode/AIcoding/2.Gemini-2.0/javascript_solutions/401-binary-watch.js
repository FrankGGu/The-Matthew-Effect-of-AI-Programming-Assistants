var readBinaryWatch = function(turnedOn) {
    const result = [];
    for (let h = 0; h < 12; h++) {
        for (let m = 0; m < 60; m++) {
            const bits = h.toString(2).split('').filter(bit => bit === '1').length + m.toString(2).split('').filter(bit => bit === '1').length;
            if (bits === turnedOn) {
                result.push(`${h}:${m < 10 ? '0' + m : m}`);
            }
        }
    }
    return result;
};