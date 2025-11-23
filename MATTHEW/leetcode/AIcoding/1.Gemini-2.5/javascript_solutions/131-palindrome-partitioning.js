var partition = function(s) {
    const result = [];
    const currentPartition = [];

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

    function backtrack(start) {
        if (start === s.length) {
            result.push([...currentPartition]);
            return;
        }

        for (let i = start; i < s.length; i++) {
            const sub = s.substring(start, i + 1);
            if (isPalindrome(sub)) {
                currentPartition.push(sub);
                backtrack(i + 1);
                currentPartition.pop();
            }
        }
    }

    backtrack(0);
    return result;
};