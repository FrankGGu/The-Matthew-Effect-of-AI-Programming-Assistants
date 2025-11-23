var countCompleteSubstrings = function(word, k) {
    let totalCount = 0;
    let startIdx = 0;
    const n_word = word.length;

    const countCompleteInSegment = (word, segStart, segEnd) => {
        let segmentCount = 0;

        for (let i = segStart; i <= segEnd; i++) {
            const counts = new Array(26).fill(0);

            for (let j = i; j <= segEnd; j++) {
                const charCode = word.charCodeAt(j) - 'a'.charCodeAt(0);
                counts[charCode]++;

                let firstCharFreq = -1;
                let isCompleteFreq = true;
                for (let char_idx = 0; char_idx < 26; char_idx++) {
                    if (counts[char_idx] > 0) {
                        if (firstCharFreq === -1) {
                            firstCharFreq = counts[char_idx];
                        } else if (counts[char_idx] !== firstCharFreq) {
                            isCompleteFreq = false;
                            break;
                        }
                    }
                }

                if (isCompleteFreq) {
                    segmentCount++;
                }
            }
        }
        return segmentCount;
    };

    for (let i = 0; i < n_word - 1; i++) {
        if (Math.abs(word.charCodeAt(i) - word.charCodeAt(i + 1)) > k) {
            totalCount += countCompleteInSegment(word, startIdx, i);
            startIdx = i + 1;
        }
    }
    totalCount += countCompleteInSegment(word, startIdx, n_word - 1);

    return totalCount;
};