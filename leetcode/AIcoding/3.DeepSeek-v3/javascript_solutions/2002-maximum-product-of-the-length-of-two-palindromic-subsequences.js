var maxProduct = function(s) {
    let n = s.length;
    let max = 0;
    let map = new Map();

    for (let mask = 1; mask < (1 << n); mask++) {
        let subseq = '';
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                subseq += s[i];
            }
        }
        if (isPalindrome(subseq)) {
            map.set(mask, subseq.length);
        }
    }

    let masks = Array.from(map.keys());
    for (let i = 0; i < masks.length; i++) {
        for (let j = i + 1; j < masks.length; j++) {
            if ((masks[i] & masks[j]) === 0) {
                max = Math.max(max, map.get(masks[i]) * map.get(masks[j]));
            }
        }
    }

    return max;
};

function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}