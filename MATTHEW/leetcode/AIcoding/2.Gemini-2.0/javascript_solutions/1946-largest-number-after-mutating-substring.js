var maximumNumber = function(num, change) {
    let n = num.length;
    let arr = num.split('');
    let start = -1;
    for (let i = 0; i < n; i++) {
        let digit = parseInt(arr[i]);
        if (change[digit] > digit) {
            start = i;
            break;
        }
    }

    if (start === -1) {
        return num;
    }

    for (let i = start; i < n; i++) {
        let digit = parseInt(arr[i]);
        if (change[digit] >= digit) {
            arr[i] = change[digit].toString();
        } else {
            break;
        }
    }

    return arr.join('');
};