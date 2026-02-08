var maximumSwap = function(num) {
    const str = num.toString();
    const n = str.length;
    const last = new Array(10).fill(-1);

    for (let i = 0; i < n; i++) {
        last[parseInt(str[i])] = i;
    }

    for (let i = 0; i < n; i++) {
        for (let d = 9; d > parseInt(str[i]); d--) {
            if (last[d] > i) {
                const arr = str.split('');
                const temp = arr[i];
                arr[i] = arr[last[d]];
                arr[last[d]] = temp;
                return parseInt(arr.join(''));
            }
        }
    }

    return num;
};