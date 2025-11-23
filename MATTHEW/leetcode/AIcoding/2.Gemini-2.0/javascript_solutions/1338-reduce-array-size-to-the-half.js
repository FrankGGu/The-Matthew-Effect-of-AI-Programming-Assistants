var minSetSize = function(arr) {
    const n = arr.length;
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }

    const counts = Object.values(count).sort((a, b) => b - a);
    let removed = 0;
    let setSize = 0;
    for (const c of counts) {
        removed += c;
        setSize++;
        if (removed >= n / 2) {
            break;
        }
    }

    return setSize;
};