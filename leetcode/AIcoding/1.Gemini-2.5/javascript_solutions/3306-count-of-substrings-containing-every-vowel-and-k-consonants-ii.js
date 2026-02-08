var countVowelSubstrings = function(s, k) {
    const N = s.length;
    let ans = 0;

    const vowelMap = { 'a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4 };
    const isVowel = (char) => vowelMap.hasOwnProperty(char);
    const ALL_VOWELS_MASK = (1 << 5) - 1; // 31

    if (k === 0) {
        let left = 0; // Start of the current all-vowel segment
        let validLeft = 0; // Leftmost index such that s[validLeft...right] has all 5 vowels
        let currentVowelFreq = new Array(5).fill(0);
        let currentVowelMask = 0;

        for (let right = 0; right < N; right++) {
            if (!isVowel(s[right])) {
                // Reset window if a consonant is encountered
                left = right + 1;
                validLeft = right + 1;
                currentVowelFreq.fill(0);
                currentVowelMask = 0;
                continue;
            }

            // Add current vowel to the window
            const vowelIdx = vowelMap[s[right]];
            currentVowelFreq[vowelIdx]++;
            currentVowelMask |= (1 << vowelIdx);

            // Shrink `validLeft` as much as possible while maintaining ALL_VOWELS_MASK
            while (currentVowelMask === ALL_VOWELS_MASK) {
                const charL = s[validLeft];
                const vIdxL = vowelMap[charL];
                currentVowelFreq[vIdxL]--;
                if (currentVowelFreq[vIdxL] === 0) {
                    currentVowelMask &= ~(1 << vIdxL);
                }
                validLeft++;
            }

            // All substrings s[L...right] where `left <= L < validLeft` are valid.
            // The number of such substrings is `validLeft - left`.
            ans += (validLeft - left);
        }
        return ans;
    }

    // For k >= 1:
    const consonantIndices = [];
    for (let i = 0; i < N; i++) {
        if (!isVowel(s[i])) {
            consonantIndices.push(i);
        }
    }

    const M = consonantIndices.length;

    if (M < k) {
        return 0;
    }

    let vowelFreq = new Array(5).fill(0);
    let vowelMask = 0;

    // Initialize for the first window of k consonants:
    // s[consonantIndices[0] ... consonantIndices[k-1]]
    for (let j = consonantIndices[0]; j <= consonantIndices[k - 1]; j++) {
        if (isVowel(s[j])) {
            const vowelIdx = vowelMap[s[j]];
            vowelFreq[vowelIdx]++;
            vowelMask |= (1 << vowelIdx);
        }
    }

    // Slide the window of k consonants
    for (let rightCptr = k - 1; rightCptr < M; rightCptr++) {
        const leftCptr = rightCptr - k + 1;

        const currentLeftConsonantIdx = consonantIndices[leftCptr];
        const currentRightConsonantIdx = consonantIndices[rightCptr];

        if (rightCptr > k - 1) { // If not the initial window, update incrementally
            // Add characters between previous right consonant and current right consonant
            const prevRightConsonantIdx = consonantIndices[rightCptr - 1];
            for (let j = prevRightConsonantIdx + 1; j <= currentRightConsonantIdx; j++) {
                if (isVowel(s[j])) {
                    const vowelIdx = vowelMap[s[j]];
                    vowelFreq[vowelIdx]++;
                    vowelMask |= (1 << vowelIdx);
                }
            }

            // Remove characters between previous left consonant and current left consonant
            const prevLeftConsonantIdx = consonantIndices[leftCptr - 1];
            for (let j = prevLeftConsonantIdx + 1; j < currentLeftConsonantIdx; j++) {
                if (isVowel(s[j])) {
                    const vowelIdx = vowelMap[s[j]];
                    vowelFreq[vowelIdx]--;
                    if (vowelFreq[vowelIdx] === 0) {
                        vowelMask &= ~(1 << vowelIdx);
                    }
                }
            }
        }

        // After updating vowelFreq and vowelMask for s[currentLeftConsonantIdx ... currentRightConsonantIdx]:
        if (vowelMask === ALL_VOWELS_MASK) {
            // Calculate number of valid left extensions
            // Any L from (prev_consonant_idx + 1) to currentLeftConsonantIdx (inclusive)
            const leftBoundary = (leftCptr > 0) ? consonantIndices[leftCptr - 1] : -1;
            const numLeftChoices = currentLeftConsonantIdx - leftBoundary;

            // Calculate number of valid right extensions
            // Any R from currentRightConsonantIdx (inclusive) to (next_consonant_idx - 1)
            const rightBoundary = (rightCptr + 1 < M) ? consonantIndices[rightCptr + 1] : N;
            const numRightChoices = rightBoundary - currentRightConsonantIdx;

            ans += numLeftChoices * numRightChoices;
        }
    }

    return ans;
};