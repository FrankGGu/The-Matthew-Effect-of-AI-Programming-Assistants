var maximumTime = function(time) {
    let arr = time.split('');

    // Handle hours
    if (arr[0] === '?') {
        if (arr[1] === '?') {
            arr[0] = '1';
            arr[1] = '2';
        } else if (arr[1] <= '3') {
            arr[0] = '1';
        } else {
            arr[0] = '0';
        }
    } else if (arr[1] === '?') {
        if (arr[0] === '2') {
            arr[1] = '3';
        } else {
            arr[1] = '9';
        }
    }

    // Handle minutes
    if (arr[3] === '?') {
        arr[3] = '5';
    }
    if (arr[4] === '?') {
        arr[4] = '9';
    }

    return arr.join('');
};