var maxEqualFreq = function(nums) {
    const freq = new Map(); // Stores element -> count
    const freqOfFreq = new Map(); // Stores count -> number of elements with that count
    let ans = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const currentLen = i + 1;

        const oldCount = freq.get(num) || 0;
        const newCount = oldCount + 1;

        // Update freqOfFreq for oldCount
        if (oldCount > 0) {
            freqOfFreq.set(oldCount, freqOfFreq.get(oldCount) - 1);
            if (freqOfFreq.get(oldCount) === 0) {
                freqOfFreq.delete(oldCount);
            }
        }

        // Update freq for num
        freq.set(num, newCount);

        // Update freqOfFreq for newCount
        freqOfFreq.set(newCount, (freqOfFreq.get(newCount) || 0) + 1);

        // Determine maxFreqVal and minFreqVal for checking conditions
        let maxFreqVal = 0;
        let minFreqVal = Infinity;

        // Optimization: Only iterate keys if freqOfFreq.size is small, as conditions only apply for size 1 or 2
        if (freqOfFreq.size <= 2) {
            for (const f of freqOfFreq.keys()) {
                maxFreqVal = Math.max(maxFreqVal, f);
                minFreqVal = Math.min(minFreqVal, f);
            }
        } else {
            // If more than 2 distinct frequencies, none of the valid patterns are met.
            continue; 
        }

        // Check conditions for currentLen to be a valid answer:
        // Condition 1: All elements appear exactly once (e.g., [1,2,3])
        // This implies freqOfFreq is {1: numUniqueElements}
        if (maxFreqVal === 1) {
            ans = currentLen;
        }
        // Condition 2: Only one unique element exists (e.g., [1,1,1])
        // This implies freqOfFreq is {f: 1} for some f > 1.
        // If f=1, it's covered by Condition 1.
        else if (freq.size === 1) { 
            ans = currentLen;
        }
        // Condition 3: Two distinct frequencies f and f+1 exist, where f+1 appears for only one element
        // (e.g., [1,1,1,2,2]) -> freqOfFreq = {3:1, 2:1}
        else if (freqOfFreq.size === 2 && maxFreqVal - minFreqVal === 1 && freqOfFreq.get(maxFreqVal) === 1) {
            ans = currentLen;
        }
        // Condition 4: Two distinct frequencies f and 1 exist, where 1 appears for only one element
        // (e.g., [1,1,2,2,3]) -> freqOfFreq = {2:2, 1:1}
        else if (freqOfFreq.size === 2 && minFreqVal === 1 && freqOfFreq.get(1) === 1) {
            ans = currentLen;
        }
    }

    return ans;
};