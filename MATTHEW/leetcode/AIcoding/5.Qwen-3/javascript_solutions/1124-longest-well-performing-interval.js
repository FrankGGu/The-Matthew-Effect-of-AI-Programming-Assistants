function longestWellPerformingInterval(rating) {
    let map = new Map();
    map.set(0, -1);
    let result = 0;
    let count = 0;
    for (let i = 0; i < rating.length; i++) {
        count += rating[i] > 7 ? 1 : -1;
        if (map.has(count)) {
            result = Math.max(result, i - map.get(count));
        } else {
            map.set(count, i);
        }
    }
    return result;
}