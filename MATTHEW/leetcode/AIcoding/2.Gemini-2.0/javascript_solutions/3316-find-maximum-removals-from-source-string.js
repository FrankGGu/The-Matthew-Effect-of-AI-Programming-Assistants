var maximumRemovals = function(s, words) {
    let left = 0;
    let right = s.length;
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const removals = new Set();
        for (let i = 0; i < mid; i++) {
            removals.add(i);
        }

        let canFormAllWords = true;
        for (const word of words) {
            let sIndex = 0;
            let wordIndex = 0;

            while (sIndex < s.length && wordIndex < word.length) {
                if (removals.has(sIndex)) {
                    sIndex++;
                    continue;
                }

                if (s[sIndex] === word[wordIndex]) {
                    wordIndex++;
                }
                sIndex++;
            }

            if (wordIndex !== word.length) {
                canFormAllWords = false;
                break;
            }
        }

        if (canFormAllWords) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};