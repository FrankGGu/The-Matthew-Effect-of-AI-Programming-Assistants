var minSetSize = function(arr) {
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }

    const sortedCounts = Object.values(count).sort((a, b) => b - a);

    let total = 0;
    let result = 0;

    for (const c of sortedCounts) {
        total += c;
        result++;
        if (total >= arr.length / 2) {
            return result;
        }
    }

    return result;
};