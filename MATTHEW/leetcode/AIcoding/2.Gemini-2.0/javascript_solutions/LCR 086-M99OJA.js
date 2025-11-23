var partition = function(s) {
    const result = [];
    const n = s.length;

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
        if (index === n) {
            result.push([...currentPartition]);
            return;
        }

        for (let i = index; i < n; i++) {
            const sub = s.substring(index, i + 1);
            if (isPalindrome(sub)) {
                currentPartition.push(sub);
                backtrack(i + 1, currentPartition);
                currentPartition.pop();
            }
        }
    }

    backtrack(0, []);
    return result;
};