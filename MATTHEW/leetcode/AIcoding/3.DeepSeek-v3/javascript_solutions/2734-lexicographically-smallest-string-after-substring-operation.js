var smallestString = function(s) {
    const arr = s.split('');
    let i = 0;
    while (i < arr.length && arr[i] === 'a') {
        i++;
    }
    if (i === arr.length) {
        arr[arr.length - 1] = 'z';
        return arr.join('');
    }
    let j = i;
    while (j < arr.length && arr[j] !== 'a') {
        arr[j] = String.fromCharCode(arr[j].charCodeAt(0) - 1);
        j++;
    }
    return arr.join('');
};