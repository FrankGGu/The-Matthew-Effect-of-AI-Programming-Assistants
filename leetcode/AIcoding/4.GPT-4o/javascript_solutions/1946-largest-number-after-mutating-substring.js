var maximumGain = function(s, x, y) {
    const n = s.length;
    let maxGain = 0;

    const calculateGain = (s, x, y, char1, char2) => {
        let gain = 0;
        let countChar1 = 0;
        let countChar2 = 0;
        for (let i = 0; i < s.length; i++) {
            if (s[i] === char1) {
                countChar1++;
            } else if (s[i] === char2) {
                countChar2++;
                if (countChar1 > 0) {
                    gain += x;
                    countChar1--;
                }
            }
        }
        return gain;
    };

    maxGain = Math.max(calculateGain(s, x, y, 'a', 'b'), calculateGain(s, y, x, 'b', 'a'));

    return maxGain;
};