var areNumbersAscending = function(s) {
    let prev = -Infinity;
    const tokens = s.split(' ');
    for (const token of tokens) {
        if (!isNaN(token)) {
            const num = parseInt(token, 10);
            if (num <= prev) {
                return false;
            }
            prev = num;
        }
    }
    return true;
};