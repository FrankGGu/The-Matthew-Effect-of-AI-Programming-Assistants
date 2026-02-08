var partition = function(s) {
    const result = [];

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

    function backtrack(index, currentPartition) {
        if (index === s.length) {
            result.push([...currentPartition]);
            return;
        }

        for (let i = index; i < s.length; i++) {
            const substring = s.substring(index, i + 1);
            if (isPalindrome(substring)) {
                currentPartition.push(substring);
                backtrack(i + 1, currentPartition);
                currentPartition.pop();
            }
        }
    }

    backtrack(0, []);
    return result;
};