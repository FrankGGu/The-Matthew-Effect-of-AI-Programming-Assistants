var customSortString = function(order, s) {
    const charCounts = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        charCounts[s.charCodeAt(i) - 97]++;
    }

    let result = [];

    for (let i = 0; i < order.length; i++) {
        const charCode = order.charCodeAt(i);
        const index = charCode - 97;
        while (charCounts[index] > 0) {
            result.push(String.fromCharCode(charCode));
            charCounts[index]--;
        }
    }

    for (let i = 0; i < 26; i++) {
        while (charCounts[i] > 0) {
            result.push(String.fromCharCode(i + 97));
            charCounts[i]--;
        }
    }

    return result.join('');
};