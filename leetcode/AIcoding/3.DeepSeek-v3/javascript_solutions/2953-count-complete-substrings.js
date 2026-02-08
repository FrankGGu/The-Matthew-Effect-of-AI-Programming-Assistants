var countCompleteSubstrings = function(word, k) {
    let count = 0;
    const n = word.length;

    for (let i = 0; i < n; ) {
        let j = i + 1;
        while (j < n && Math.abs(word.charCodeAt(j) - word.charCodeAt(j - 1)) <= 2) {
            j++;
        }
        count += helper(word.substring(i, j), k);
        i = j;
    }

    return count;
};

function helper(s, k) {
    let res = 0;
    const n = s.length;

    for (let unique = 1; unique <= 26; unique++) {
        if (unique * k > n) break;

        const freq = new Array(26).fill(0);
        let left = 0;
        let countUnique = 0;
        let countK = 0;

        for (let right = 0; right < n; right++) {
            const c = s.charCodeAt(right) - 'a'.charCodeAt(0);
            freq[c]++;

            if (freq[c] === 1) countUnique++;
            if (freq[c] === k) countK++;

            while (countUnique > unique) {
                const leftChar = s.charCodeAt(left) - 'a'.charCodeAt(0);
                freq[leftChar]--;
                if (freq[leftChar] === 0) countUnique--;
                if (freq[leftChar] === k - 1) countK--;
                left++;
            }

            if (countUnique === unique && countK === unique) {
                res++;
            }
        }
    }

    return res;
}