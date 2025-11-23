function minOperations(target, arr) {
    const map = new Map();
    for (let i = 0; i < arr.length; i++) {
        if (!map.has(arr[i])) {
            map.set(arr[i], i);
        }
    }

    let res = 0;
    let pos = 0;

    for (let i = 0; i < target.length; i++) {
        if (map.has(target[i])) {
            if (map.get(target[i]) >= pos) {
                pos = map.get(target[i]) + 1;
            } else {
                res++;
            }
        } else {
            res++;
        }
    }

    return res;
}