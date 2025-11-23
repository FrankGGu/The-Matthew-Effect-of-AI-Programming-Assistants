var secondsToRemoveOccurrences = function(s) {
    let count = 0;
    let changed = true;
    let arr = s.split('');

    while (changed) {
        changed = false;
        for (let i = 0; i < arr.length - 1; i++) {
            if (arr[i] === '0' && arr[i + 1] === '1') {
                [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
                i++;
                changed = true;
            }
        }
        if (changed) {
            count++;
        }
    }

    return count;
};