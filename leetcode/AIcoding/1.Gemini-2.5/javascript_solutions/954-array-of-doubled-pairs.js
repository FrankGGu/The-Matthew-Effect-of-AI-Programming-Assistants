var canReorderDoubled = function(arr) {
    const counts = new Map();
    for (const num of arr) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    arr.sort((a, b) => Math.abs(a) - Math.abs(b));

    for (const num of arr) {
        if (counts.get(num) === 0) {
            continue;
        }

        counts.set(num, counts.get(num) - 1);

        const target = 2 * num;

        if ((counts.get(target) || 0) === 0) {
            return false;
        }
        counts.set(target, counts.get(target) - 1);
    }

    return true;
};