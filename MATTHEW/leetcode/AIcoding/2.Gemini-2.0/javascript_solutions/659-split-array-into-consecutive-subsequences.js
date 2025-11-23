var isPossible = function(nums) {
    const freq = {};
    const need = {};

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    for (const num of nums) {
        if (freq[num] === 0) continue;

        if (need[num] > 0) {
            need[num]--;
            freq[num]--;
            need[num + 1] = (need[num + 1] || 0) + 1;
        } else if (freq[num + 1] > 0 && freq[num + 2] > 0) {
            freq[num]--;
            freq[num + 1]--;
            freq[num + 2]--;
            need[num + 3] = (need[num + 3] || 0) + 1;
        } else {
            return false;
        }
    }

    return true;
};