var numMatchingSubseq = function(s, words) {
    const map = new Map();
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (!map.has(char)) {
            map.set(char, []);
        }
        map.get(char).push(i);
    }

    let count = 0;

    for (const word of words) {
        let prev = -1;
        let found = true;
        for (const char of word) {
            if (!map.has(char)) {
                found = false;
                break;
            }
            const indices = map.get(char);
            let left = 0, right = indices.length;
            while (left < right) {
                const mid = Math.floor((left + right) / 2);
                if (indices[mid] > prev) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            if (left === indices.length) {
                found = false;
                break;
            }
            prev = indices[left];
        }
        if (found) {
            count++;
        }
    }

    return count;
};