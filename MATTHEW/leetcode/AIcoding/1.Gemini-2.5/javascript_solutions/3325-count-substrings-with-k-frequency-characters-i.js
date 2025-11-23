function countSubstringsWithKFrequency(s, k) {
    let totalCount = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const freq = new Array(26).fill(0);

        for (let j = i; j < n; j++) {
            freq[s.charCodeAt(j) - 'a'.charCodeAt(0)]++;

            let isValid = true;
            for (let charCode = 0; charCode < 26; charCode++) {
                if (freq[charCode] > 0 && freq[charCode] < k) {
                    isValid = false;
                    break;
                }
            }

            if (isValid) {
                totalCount++;
            }
        }
    }

    return totalCount;
}