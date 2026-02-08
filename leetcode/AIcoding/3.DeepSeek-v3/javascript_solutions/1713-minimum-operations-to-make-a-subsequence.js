var minOperations = function(target, arr) {
    const indexMap = new Map();
    for (let i = 0; i < target.length; i++) {
        indexMap.set(target[i], i);
    }

    const lis = [];
    for (const num of arr) {
        if (indexMap.has(num)) {
            const idx = indexMap.get(num);
            const pos = binarySearch(lis, idx);
            if (pos === lis.length) {
                lis.push(idx);
            } else {
                lis[pos] = idx;
            }
        }
    }

    return target.length - lis.length;
};

function binarySearch(arr, target) {
    let left = 0;
    let right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}