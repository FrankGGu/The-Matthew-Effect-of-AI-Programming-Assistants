var uniqueSubsequences = function(nums) {
    let count = 0;
    for (let i = 0; i < (1 << nums.length); i++) {
        if (i === 0) continue;

        let sub = [];
        for (let j = 0; j < nums.length; j++) {
            if ((i >> j) & 1) {
                sub.push(nums[j]);
            }
        }

        if (sub.length % 2 === 1) {
            let mid = Math.floor(sub.length / 2);
            let mode = sub[mid];
            let isUnique = true;

            let freq = {};
            for (let num of sub) {
                freq[num] = (freq[num] || 0) + 1;
            }

            let maxFreq = 0;
            let modeCount = 0;
            for (let num in freq) {
                if (freq[num] > maxFreq) {
                    maxFreq = freq[num];
                    modeCount = 1;
                } else if (freq[num] === maxFreq) {
                    modeCount++;
                }
            }

            if (modeCount > 1) {
                isUnique = false;
            } else {
               let currentModeFreq = 0;
               for (let num in freq) {
                   if (freq[num] > currentModeFreq) {
                       currentModeFreq = freq[num];
                   }
               }

               let uniqueMode = true;
               let modeVal;
               let modeFreqCount = 0;
               for (let num in freq) {
                   if (freq[num] === currentModeFreq) {
                       modeVal = num;
                       modeFreqCount++;
                   }
               }

               if (modeFreqCount > 1) {
                   uniqueMode = false;
               }

               if (uniqueMode) {
                    if (parseInt(modeVal) !== mode) {
                        isUnique = false;
                    }
               } else {
                   isUnique = false;
               }
            }

            if (isUnique) {
                count++;
            }
        }
    }
    return count;
};