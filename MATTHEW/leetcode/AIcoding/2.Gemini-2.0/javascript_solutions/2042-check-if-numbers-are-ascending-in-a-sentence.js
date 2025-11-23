var areNumbersAscending = function(s) {
    let prev = -1;
    const words = s.split(" ");
    for (const word of words) {
        if (!isNaN(Number(word))) {
            const num = Number(word);
            if (num <= prev) {
                return false;
            }
            prev = num;
        }
    }
    return true;
};