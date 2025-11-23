var digitSum = function(s, k) {
    while (s.length > k) {
        let newS = "";
        for (let i = 0; i < s.length; i += k) {
            let sum = 0;
            for (let j = i; j < Math.min(i + k, s.length); j++) {
                sum += parseInt(s[j]);
            }
            newS += sum.toString();
        }
        s = newS;
    }
    return s;
};