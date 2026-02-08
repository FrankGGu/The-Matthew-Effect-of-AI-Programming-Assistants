var modifyString = function(s) {
    const arr = s.split('');
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === '?') {
            for (let c of 'abcdefghijklmnopqrstuvwxyz') {
                if ((i === 0 || c !== arr[i - 1]) && (i === arr.length - 1 || c !== arr[i + 1])) {
                    arr[i] = c;
                    break;
                }
            }
        }
    }
    return arr.join('');
};