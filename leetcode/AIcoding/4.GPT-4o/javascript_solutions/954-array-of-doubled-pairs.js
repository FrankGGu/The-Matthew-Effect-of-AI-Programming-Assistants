var canReorderDoubled = function(A) {
    const count = new Map();
    for (const num of A) {
        count.set(num, (count.get(num) || 0) + 1);
    }
    const keys = Array.from(count.keys()).sort((a, b) => Math.abs(a) - Math.abs(b));
    for (const key of keys) {
        if (count.get(key) > (count.get(key * 2) || 0)) {
            return false;
        }
        count.set(key * 2, (count.get(key * 2) || 0) - count.get(key));
    }
    return true;
};