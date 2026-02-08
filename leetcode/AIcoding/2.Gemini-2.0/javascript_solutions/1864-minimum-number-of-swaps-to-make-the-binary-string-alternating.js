var minSwaps = function(s) {
    let zeros = 0;
    let ones = 0;
    for (let char of s) {
        if (char === '0') {
            zeros++;
        } else {
            ones++;
        }
    }

    if (Math.abs(zeros - ones) > 1) {
        return -1;
    }

    if (zeros > ones) {
        let swaps = 0;
        for (let i = 0; i < s.length; i++) {
            if (i % 2 === 0 && s[i] === '1') {
                swaps++;
            } else if (i % 2 === 1 && s[i] === '0') {
                swaps++;
            }
        }
        return swaps;
    } else if (ones > zeros) {
        let swaps = 0;
        for (let i = 0; i < s.length; i++) {
            if (i % 2 === 0 && s[i] === '0') {
                swaps++;
            } else if (i % 2 === 1 && s[i] === '1') {
                swaps++;
            }
        }
        return swaps;
    } else {
        let swaps0 = 0;
        for (let i = 0; i < s.length; i++) {
            if (i % 2 === 0 && s[i] === '1') {
                swaps0++;
            } else if (i % 2 === 1 && s[i] === '0') {
                swaps0++;
            }
        }

        let swaps1 = 0;
        for (let i = 0; i < s.length; i++) {
            if (i % 2 === 0 && s[i] === '0') {
                swaps1++;
            } else if (i % 2 === 1 && s[i] === '1') {
                swaps1++;
            }
        }

        return Math.min(swaps0, swaps1);
    }
};