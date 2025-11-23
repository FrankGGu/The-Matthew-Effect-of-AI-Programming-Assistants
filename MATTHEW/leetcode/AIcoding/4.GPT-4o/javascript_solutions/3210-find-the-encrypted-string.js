var encode = function(s) {
    let count = 1;
    let result = '';

    for (let i = 1; i <= s.length; i++) {
        if (s[i] === s[i - 1]) {
            count++;
        } else {
            if (count > 1) result += count;
            result += s[i - 1];
            count = 1;
        }
    }

    return result;
};

var decode = function(s) {
    let result = '';
    let i = 0;

    while (i < s.length) {
        let j = i;
        while (j < s.length && !isNaN(s[j])) j++;
        let count = j > i ? parseInt(s.slice(i, j)) : 1;
        result += s[j].repeat(count);
        i = j + 1;
    }

    return result;
};