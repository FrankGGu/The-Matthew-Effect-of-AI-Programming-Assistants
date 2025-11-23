var beautySum = function(s) {
    let sum = 0;
    for (let i = 0; i < s.length; i++) {
        const freq = new Array(26).fill(0);
        for (let j = i; j < s.length; j++) {
            freq[s.charCodeAt(j) - 'a'.charCodeAt(0)]++;
            let max = -Infinity;
            let min = Infinity;
            for (let k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    max = Math.max(max, freq[k]);
                    min = Math.min(min, freq[k]);
                }
            }
            sum += max - min;
        }
    }
    return sum;
};