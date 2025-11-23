var captureForts = function(forts) {
    let max = 0;
    let last = -1;
    for (let i = 0; i < forts.length; i++) {
        if (forts[i] !== 0) {
            if (last !== -1 && forts[i] !== forts[last]) {
                let count = 0;
                for (let j = last + 1; j < i; j++) {
                    if (forts[j] === 0) {
                        count++;
                    } else {
                        count = 0;
                        break;
                    }
                }
                max = Math.max(max, count);
            }
            last = i;
        }
    }
    return max;
};