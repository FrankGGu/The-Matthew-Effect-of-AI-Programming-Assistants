var areNumbersAscending = function(s) {
    let prevNum = -1;
    const words = s.split(' ');

    for (const word of words) {
        if (/^\d+$/.test(word)) {
            const currentNum = parseInt(word);
            if (currentNum <= prevNum) {
                return false;
            }
            prevNum = currentNum;
        }
    }

    return true;
};