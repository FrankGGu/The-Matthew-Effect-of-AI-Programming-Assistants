var digitSum = function(s, k) {
    while (s.length > k) {
        let newStr = '';
        for (let i = 0; i < s.length; i += k) {
            const chunk = s.slice(i, i + k);
            let sum = 0;
            for (const c of chunk) {
                sum += parseInt(c, 10);
            }
            newStr += sum.toString();
        }
        s = newStr;
    }
    return s;
};