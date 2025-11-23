var isPossible = function(nums) {
    const freq = new Map();
    const end = new Map();

    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    for (const num of nums) {
        if (freq.get(num) === 0) {
            continue;
        }

        freq.set(num, freq.get(num) - 1);

        if ((end.get(num - 1) || 0) > 0) {
            end.set(num - 1, end.get(num - 1) - 1);
            end.set(num, (end.get(num) || 0) + 1);
        } else if ((freq.get(num + 1) || 0) > 0 && (freq.get(num + 2) || 0) > 0) {
            freq.set(num + 1, freq.get(num + 1) - 1);
            freq.set(num + 2, freq.get(num + 2) - 1);
            end.set(num + 2, (end.get(num + 2) || 0) + 1);
        } else {
            return false;
        }
    }

    return true;
};