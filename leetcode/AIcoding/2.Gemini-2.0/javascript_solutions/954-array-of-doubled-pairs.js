var canReorderDoubled = function(arr) {
    const count = {};
    for (const num of arr) {
        count[num] = (count[num] || 0) + 1;
    }

    arr.sort((a, b) => Math.abs(a) - Math.abs(b));

    for (const num of arr) {
        if (count[num] > 0) {
            const doubled = num * 2;
            if (count[doubled] > 0) {
                count[num]--;
                count[doubled]--;
            } else {
                return false;
            }
        }
    }

    return true;
};