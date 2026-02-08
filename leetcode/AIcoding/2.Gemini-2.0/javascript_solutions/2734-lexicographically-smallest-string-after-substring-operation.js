var smallestString = function(s) {
    let n = s.length;
    let arr = s.split('');
    let start = -1;
    for (let i = 0; i < n; i++) {
        if (arr[i] !== 'a') {
            start = i;
            break;
        }
    }
    if (start === -1) {
        arr[n - 1] = 'z';
        return arr.join('');
    }
    let end = start;
    while (end < n && arr[end] !== 'a') {
        arr[end] = String.fromCharCode(arr[end].charCodeAt(0) - 1);
        end++;
    }
    return arr.join('');
};