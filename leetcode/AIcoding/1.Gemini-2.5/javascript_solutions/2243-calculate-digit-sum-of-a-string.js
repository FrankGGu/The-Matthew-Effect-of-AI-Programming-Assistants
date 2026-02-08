var digitSum = function(s, k) {
    function calculateSum(sub) {
        let currentSum = 0;
        for (let i = 0; i < sub.length; i++) {
            currentSum += parseInt(sub[i]);
        }
        return currentSum.toString();
    }

    while (s.length > k) {
        let nextS = "";
        for (let i = 0; i < s.length; i += k) {
            let sub = s.substring(i, Math.min(i + k, s.length));
            nextS += calculateSum(sub);
        }
        s = nextS;
    }

    return s;
};