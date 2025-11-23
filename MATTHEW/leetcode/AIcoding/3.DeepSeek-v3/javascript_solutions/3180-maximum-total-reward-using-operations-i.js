var maxTotalReward = function(rewardValues) {
    rewardValues.sort((a, b) => a - b);
    let maxReward = 0;
    let dp = new Set();
    dp.add(0);

    for (const num of rewardValues) {
        const temp = new Set();
        for (const val of dp) {
            if (val < num) {
                const newVal = val + num;
                if (newVal > maxReward) {
                    maxReward = newVal;
                }
                temp.add(newVal);
            }
        }
        for (const val of temp) {
            dp.add(val);
        }
    }

    return maxReward;
};