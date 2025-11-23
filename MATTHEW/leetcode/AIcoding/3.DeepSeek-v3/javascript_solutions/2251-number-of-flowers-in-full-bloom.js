var fullBloomFlowers = function(flowers, people) {
    const starts = flowers.map(f => f[0]).sort((a, b) => a - b);
    const ends = flowers.map(f => f[1] + 1).sort((a, b) => a - b);

    const binarySearch = (arr, target) => {
        let left = 0, right = arr.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    };

    return people.map(day => {
        const started = binarySearch(starts, day);
        const ended = binarySearch(ends, day);
        return started - ended;
    });
};