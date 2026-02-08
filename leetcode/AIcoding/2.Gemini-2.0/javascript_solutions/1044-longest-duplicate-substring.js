var longestDupSubstring = function(s) {
    let n = s.length;
    let low = 1, high = n - 1;
    let ans = "";

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let dup = findDup(s, mid);
        if (dup !== "") {
            ans = dup;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;

    function findDup(s, len) {
        let a = 26;
        let modulus = 2**32;
        let h = 1;
        for (let i = 0; i < len - 1; i++) {
            h = (h * a) % modulus;
        }

        let curr = 0;
        for (let i = 0; i < len; i++) {
            curr = (curr * a + (s.charCodeAt(i) - 'a'.charCodeAt(0))) % modulus;
        }

        let seen = new Set();
        seen.add(curr);

        for (let i = 1; i <= n - len; i++) {
            curr = (curr - (s.charCodeAt(i - 1) - 'a'.charCodeAt(0)) * h % modulus + modulus) % modulus;
            curr = (curr * a + (s.charCodeAt(i + len - 1) - 'a'.charCodeAt(0))) % modulus;

            if (seen.has(curr)) {
                return s.substring(i, i + len);
            }

            seen.add(curr);
        }

        return "";
    }
};