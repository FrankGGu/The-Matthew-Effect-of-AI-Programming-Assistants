var kMirror = function(n, k) {
    let count = 0;
    let sum = 0;
    let len = 1;

    while (count < n) {
        let start = Math.pow(10, Math.floor((len - 1) / 2));
        let end = Math.pow(10, Math.floor(len / 2));

        for (let i = start; i < end; i++) {
            let numStr = i.toString();
            let mirrorNumStr = numStr;
            if (len % 2 === 0) {
                mirrorNumStr += numStr.split("").reverse().join("");
            } else {
                mirrorNumStr += numStr.split("").reverse().slice(1).join("");
            }

            let num = BigInt(mirrorNumStr);

            if (isKPalindrome(num, k)) {
                sum += Number(num);
                count++;
                if (count === n) break;
            }
        }
        len++;
    }
    return sum;

    function isKPalindrome(num, k) {
        let numStr = num.toString(k);
        let left = 0;
        let right = numStr.length - 1;

        while (left < right) {
            if (numStr[left] !== numStr[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};