function digitSum(s) {
    while (s.length > 1) {
        let newS = '';
        for (let i = 0; i < s.length; i++) {
            let sum = 0;
            for (let j = 0; j < 2; j++) {
                if (i + j < s.length) {
                    sum += parseInt(s[i + j]);
                }
            }
            newS += sum;
        }
        s = newS;
    }
    return s;
}