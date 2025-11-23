var isPossible = function(nums) {
    const freq = {};
    const appendFreq = {};

    for (let num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    for (let num of nums) {
        if (freq[num] === 0) continue;

        if (appendFreq[num] > 0) {
            appendFreq[num]--;
            appendFreq[num + 1] = (appendFreq[num + 1] || 0) + 1;
        } else if (freq[num + 1] > 0 && freq[num + 2] > 0) {
            freq[num + 1]--;
            freq[num + 2]--;
            appendFreq[num + 3] = (appendFreq[num + 3] || 0) + 1;
        } else {
            return false;
        }
        freq[num]--;
    }

    return true;
};