var rearrangeCharacters = function(s, target, k) {
    const sFreq = {};
    const targetFreq = {};

    for (const char of s) {
        sFreq[char] = (sFreq[char] || 0) + 1;
    }

    for (const char of target) {
        targetFreq[char] = (targetFreq[char] || 0) + 1;
    }

    for (const char in targetFreq) {
        if (!sFreq[char]) {
            return false;
        }
    }

    let count = 0;
    while (true) {
        let possible = true;
        for (const char in targetFreq) {
            if (sFreq[char] < targetFreq[char]) {
                possible = false;
                break;
            }
        }

        if (!possible) {
            break;
        }

        for (const char in targetFreq) {
            sFreq[char] -= targetFreq[char];
        }
        count++;
    }

    return count >= k;
};