var digitSum = function(s, k) {
    while (s.length > k) {
        let parts = [];
        for (let i = 0; i < s.length; i += k) {
            parts.push(s.slice(i, i + k));
        }
        s = parts.map(part => part.split('').reduce((a, b) => a + parseInt(b), 0).toString()).join('');
    }
    return s;
};