function findLucky(arr) {
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }
    for (const key in count) {
        if (count[key] === parseInt(key)) {
            return parseInt(key);
        }
    }
    return -1;
}