var maxScore = function(s) {
    let max = 0;
    for (let i = 1; i < s.length; i++) {
        let left = s.substring(0, i).split('0').length - 1;
        let right = s.substring(i).split('1').length - 1;
        max = Math.max(max, left + right);
    }
    return max;
};