var maximizeFrequencyScore = function(nums, k) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const freq = Object.entries(count).map(([num, freq]) => [parseInt(num), freq]);
    freq.sort((a, b) => b[1] - a[1]);

    let maxScore = 0;
    for (let i = 0; i < freq.length; i++) {
        let [num, f] = freq[i];
        maxScore += f * num;
        if (k > 0) {
            const nextNum = freq[i + 1] ? freq[i + 1][0] : null;
            if (nextNum !== null && nextNum - num <= k) {
                const canAdd = Math.min(k / (nextNum - num), f);
                maxScore += canAdd * nextNum;
                k -= canAdd * (nextNum - num);
            }
        }
    }
    return maxScore;
};