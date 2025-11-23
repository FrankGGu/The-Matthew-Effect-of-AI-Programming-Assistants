var reverseDegree = function(s) {
    let n = s.length;
    let arr = s.split('');
    for (let i = 0; i < n / 2; i++) {
        [arr[i], arr[n - 1 - i]] = [arr[n - 1 - i], arr[i]];
    }
    return arr.join('');
};