var kMirror = function(k, n) {
    const isPalindrome = (num) => {
        const str = num.toString();
        return str === str.split('').reverse().join('');
    };

    const convertToBaseK = (num, base) => {
        let result = '';
        while (num > 0) {
            result = (num % base) + result;
            num = Math.floor(num / base);
        }
        return result;
    };

    let count = 0;
    let sum = 0;
    let num = 1;

    while (count < n) {
        if (isPalindrome(num) && isPalindrome(convertToBaseK(num, k))) {
            sum += num;
            count++;
        }
        num++;
    }

    return sum;
};