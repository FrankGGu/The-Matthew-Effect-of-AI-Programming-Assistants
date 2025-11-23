function fullBloomFlowers(flowers, people) {
    const start = [];
    const end = [];

    for (const [s, e] of flowers) {
        start.push(s);
        end.push(e);
    }

    start.sort((a, b) => a - b);
    end.sort((a, b) => a - b);

    const res = [];

    for (const t of people) {
        const open = binarySearch(start, t);
        const close = binarySearch(end, t);
        res.push(open - close);
    }

    return res;
}

function binarySearch(arr, target) {
    let left = 0;
    let right = arr.length;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}