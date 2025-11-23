var canBeValid = function(s, locked) {
    if (s.length % 2 !== 0) return false;
    let minOpen = 0, maxOpen = 0;
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        const lock = locked[i] === '1';
        if (lock) {
            if (char === '(') {
                minOpen++;
                maxOpen++;
            } else {
                minOpen--;
                maxOpen--;
            }
        } else {
            minOpen--;
            maxOpen++;
        }
        if (maxOpen < 0) return false;
        minOpen = Math.max(minOpen, 0);
    }
    return minOpen === 0;
};