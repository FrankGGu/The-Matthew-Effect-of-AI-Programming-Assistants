var isMagic = function(target) {
    const n = target.length;
    let k = 0;
    let arr = Array.from({length: n}, (_, i) => i + 1);

    while (true) {
        const odd = [];
        const even = [];
        for (let i = 0; i < arr.length; i++) {
            if (i % 2 === 1) {
                odd.push(arr[i]);
            } else {
                even.push(arr[i]);
            }
        }
        const newArr = odd.concat(even);
        let match = true;
        for (let i = 0; i < newArr.length; i++) {
            if (newArr[i] !== target[i]) {
                match = false;
                break;
            }
        }
        if (match) {
            k = newArr.length;
            break;
        }
        if (newArr.length === 0) {
            break;
        }
        arr = newArr;
    }

    if (k === 0) {
        return false;
    }

    arr = Array.from({length: n}, (_, i) => i + 1);
    for (let i = 0; i < k; i++) {
        const odd = [];
        const even = [];
        for (let j = 0; j < arr.length; j++) {
            if (j % 2 === 1) {
                odd.push(arr[j]);
            } else {
                even.push(arr[j]);
            }
        }
        arr = odd.concat(even);
    }

    for (let i = 0; i < n; i++) {
        if (arr[i] !== target[i]) {
            return false;
        }
    }

    return true;
};