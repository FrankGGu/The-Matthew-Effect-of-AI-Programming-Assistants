var maxProduct = function(s) {
    const n = s.length;
    let maxProd = 0;

    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    function solve(mask1, mask2) {
        let seq1 = "";
        let seq2 = "";

        for (let i = 0; i < n; i++) {
            if ((mask1 >> i) & 1) {
                seq1 += s[i];
            }
            if ((mask2 >> i) & 1) {
                seq2 += s[i];
            }
        }

        if (isPalindrome(seq1) && isPalindrome(seq2)) {
            return seq1.length * seq2.length;
        }

        return 0;
    }

    for (let mask1 = 1; mask1 < (1 << n); mask1++) {
        for (let mask2 = 1; mask2 < (1 << n); mask2++) {
            if ((mask1 & mask2) === 0) {
                maxProd = Math.max(maxProd, solve(mask1, mask2));
            }
        }
    }

    return maxProd;
};