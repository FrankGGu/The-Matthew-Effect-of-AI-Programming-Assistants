function specialBinaryString(s) {
    function helper(s) {
        let res = [];
        let count = 0;
        let start = 0;
        for (let i = 0; i < s.length; i++) {
            if (s[i] === '1') count++;
            else count--;
            if (count === 0) {
                res.push('1' + helper(s.substring(start + 1, i)) + '0');
                start = i + 1;
            }
        }
        return res.sort().join('');
    }
    return helper(s);
}