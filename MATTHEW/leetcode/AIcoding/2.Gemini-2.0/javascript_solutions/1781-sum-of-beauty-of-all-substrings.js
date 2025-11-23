var beautySum = function(s) {
    let sum = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            let sub = s.substring(i, j + 1);
            let counts = {};
            for (let k = 0; k < sub.length; k++) {
                counts[sub[k]] = (counts[sub[k]] || 0) + 1;
            }
            let min = Infinity;
            let max = -Infinity;
            for (let char in counts) {
                min = Math.min(min, counts[char]);
                max = Math.max(max, counts[char]);
            }
            sum += max - min;
        }
    }
    return sum;
};