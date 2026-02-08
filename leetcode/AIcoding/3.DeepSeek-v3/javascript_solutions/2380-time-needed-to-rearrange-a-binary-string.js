var secondsToRemoveOccurrences = function(s) {
    let seconds = 0;
    let str = s;
    while (true) {
        let changed = false;
        let newStr = '';
        let i = 0;
        while (i < str.length) {
            if (i < str.length - 1 && str[i] === '0' && str[i + 1] === '1') {
                newStr += '10';
                i += 2;
                changed = true;
            } else {
                newStr += str[i];
                i += 1;
            }
        }
        if (!changed) break;
        str = newStr;
        seconds++;
    }
    return seconds;
};