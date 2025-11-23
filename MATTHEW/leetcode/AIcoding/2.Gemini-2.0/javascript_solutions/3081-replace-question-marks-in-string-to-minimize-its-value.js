var modifyString = function(s) {
    let arr = s.split('');
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === '?') {
            for (let char of ['a', 'b', 'c']) {
                if ((i > 0 && arr[i - 1] === char) || (i < arr.length - 1 && arr[i + 1] === char)) {
                    continue;
                }
                arr[i] = char;
                break;
            }
        }
    }
    return arr.join('');
};