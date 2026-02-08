var longestSubsequenceRepeatedK = function(s, k) {
    let n = s.length;
    let alphabet = "abcdefghijklmnopqrstuvwxyz";
    let ans = "";

    function isValid(sub) {
        let count = 0;
        let i = 0;
        let j = 0;
        while (i < n && count < k) {
            if (s[i] === sub[j]) {
                j++;
                if (j === sub.length) {
                    count++;
                    j = 0;
                }
            }
            i++;
        }
        return count === k;
    }

    let q = [""];

    while (q.length > 0) {
        let curr = q.shift();
        if (isValid(curr)) {
            ans = curr;
            for (let char of alphabet) {
                q.push(curr + char);
            }
        }
    }

    return ans;
};