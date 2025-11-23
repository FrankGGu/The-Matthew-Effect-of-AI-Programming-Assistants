var customSortString = function(order, s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }

    let result = '';
    for (const char of order) {
        if (count[char]) {
            result += char.repeat(count[char]);
            delete count[char];
        }
    }

    for (const char in count) {
        result += char.repeat(count[char]);
    }

    return result;
};