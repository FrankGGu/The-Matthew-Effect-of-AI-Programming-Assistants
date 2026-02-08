var minNumberOfFrogs = function(croakOfFrogs) {
    const count = { 'c': 0, 'r': 0, 'o': 0, 'a': 0, 'k': 0 };
    let maxFrogs = 0;
    let currentFrogs = 0;

    for (const ch of croakOfFrogs) {
        count[ch]++;

        if (ch === 'c') {
            currentFrogs++;
            maxFrogs = Math.max(maxFrogs, currentFrogs);
        } else if (ch === 'k') {
            currentFrogs--;
        }

        if (count['c'] < count['r'] || count['r'] < count['o'] || count['o'] < count['a'] || count['a'] < count['k']) {
            return -1;
        }
    }

    if (currentFrogs !== 0 || count['c'] !== count['r'] || count['r'] !== count['o'] || count['o'] !== count['a'] || count['a'] !== count['k']) {
        return -1;
    }

    return maxFrogs;
};