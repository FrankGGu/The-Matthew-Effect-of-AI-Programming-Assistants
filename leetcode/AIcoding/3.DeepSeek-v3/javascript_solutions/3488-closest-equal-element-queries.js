var closestEqualElementQueries = function(arr, queries) {
    const map = new Map();
    for (let i = 0; i < arr.length; i++) {
        if (!map.has(arr[i])) {
            map.set(arr[i], []);
        }
        map.get(arr[i]).push(i);
    }

    const result = [];
    for (const [target, index] of queries) {
        if (!map.has(target)) {
            result.push(-1);
            continue;
        }
        const indices = map.get(target);
        const pos = binarySearch(indices, index);
        if (pos === 0) {
            result.push(indices[0]);
        } else if (pos === indices.length) {
            result.push(indices[indices.length - 1]);
        } else {
            const left = indices[pos - 1];
            const right = indices[pos];
            if (index - left <= right - index) {
                result.push(left);
            } else {
                result.push(right);
            }
        }
    }
    return result;
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