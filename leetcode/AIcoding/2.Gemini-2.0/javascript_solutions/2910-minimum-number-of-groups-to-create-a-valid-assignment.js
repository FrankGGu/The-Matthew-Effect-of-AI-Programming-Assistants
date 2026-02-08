var minGroupsForValidAssignment = function(nums) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    const freqs = Object.values(counts);
    freqs.sort((a, b) => a - b);

    let minGroups = nums.length;
    for (let size = freqs[0]; size >= 1; --size) {
        let groups = 0;
        let possible = true;
        for (const freq of freqs) {
            let numGroups = 0;
            if (freq < size) {
                possible = false;
                break;
            } else if (freq % (size + 1) === 0) {
                numGroups = freq / (size + 1);
            } else if (freq % (size + 1) <= freq / (size + 1)) {
                numGroups = Math.floor(freq / (size + 1)) + 1;
            } else {
                let possible2 = false;
                for(let k = 0; k <= Math.floor(freq / size); k++) {
                    if ((freq - k * size) % (size + 1) == 0 && (freq - k * size) >= 0) {
                        numGroups = k + (freq - k * size) / (size + 1);
                        possible2 = true;
                        break;
                    }
                }
                if (!possible2) {
                    possible = false;
                    break;
                }
            }
            groups += numGroups;
        }

        if (possible) {
            minGroups = groups;
            break;
        }
    }

    return minGroups;
};