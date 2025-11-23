var canReorderDoubled = function(arr) {
    const count = new Map();
    for (const num of arr) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const sorted = [...arr].sort((a, b) => Math.abs(a) - Math.abs(b));

    for (const num of sorted) {
        if (count.get(num) === 0) continue;
        const double = num * 2;
        if (!count.has(double) || count.get(double) === 0) {
            return false;
        }
        count.set(num, count.get(num) - 1);
        count.set(double, count.get(double) - 1);
    }

    return true;
};