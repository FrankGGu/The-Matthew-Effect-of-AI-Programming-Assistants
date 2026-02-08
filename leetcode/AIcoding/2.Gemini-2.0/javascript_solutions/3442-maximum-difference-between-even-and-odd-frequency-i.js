var maxFrequencyDifference = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let maxDiff = -Infinity;
    for (const even of Object.keys(freq)) {
        if (even % 2 === 0) {
            for (const odd of Object.keys(freq)) {
                if (odd % 2 !== 0) {
                    maxDiff = Math.max(maxDiff, freq[even] - freq[odd]);
                }
            }
        }
    }

    let hasEven = false;
    let hasOdd = false;
    for(const num of Object.keys(freq)){
        if(num % 2 === 0){
            hasEven = true;
        }
        else {
            hasOdd = true;
        }
    }

    if(!hasEven || !hasOdd){
        return -1;
    }

    return maxDiff;
};