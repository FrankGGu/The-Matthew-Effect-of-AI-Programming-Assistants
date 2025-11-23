var maximum69Number  = function(num) {
    let s = num.toString();
    let arr = s.split('');
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === '6') {
            arr[i] = '9';
            break;
        }
    }
    return parseInt(arr.join(''));
};