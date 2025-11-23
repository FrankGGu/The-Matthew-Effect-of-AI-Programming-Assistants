function findLexSmallestString(s) {
    function getMin(s) {
        let res = s;
        for (let i = 0; i < s.length; i++) {
            let temp = s.split('');
            if (i % 2 === 1) {
                temp[i] = String.fromCharCode((temp[i].charCodeAt(0) - '0'.charCodeAt(0) + 1) % 10 + '0'.charCodeAt(0));
            } else {
                temp[i] = String.fromCharCode((temp[i].charCodeAt(0) - '0'.charCodeAt(0) + 2) % 10 + '0'.charCodeAt(0));
            }
            temp = temp.join('');
            if (temp < res) {
                res = temp;
            }
        }
        return res;
    }

    let minStr = s;
    for (let i = 0; i < s.length; i++) {
        let temp = s.split('');
        if (i % 2 === 1) {
            temp[i] = String.fromCharCode((temp[i].charCodeAt(0) - '0'.charCodeAt(0) + 1) % 10 + '0'.charCodeAt(0));
        } else {
            temp[i] = String.fromCharCode((temp[i].charCodeAt(0) - '0'.charCodeAt(0) + 2) % 10 + '0'.charCodeAt(0));
        }
        temp = temp.join('');
        minStr = Math.min(minStr, temp);
        minStr = Math.min(minStr, getMin(temp));
    }
    return minStr;
}