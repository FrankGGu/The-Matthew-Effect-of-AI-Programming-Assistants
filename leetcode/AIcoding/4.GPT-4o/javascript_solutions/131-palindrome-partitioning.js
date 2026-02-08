var partition = function(s) {
    const result = [];
    const path = [];

    const isPalindrome = (str) => {
        let left = 0, right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) return false;
            left++;
            right--;
        }
        return true;
    };

    const backtrack = (start) => {
        if (start === s.length) {
            result.push([...path]);
            return;
        }

        for (let end = start; end < s.length; end++) {
            const substring = s.substring(start, end + 1);
            if (isPalindrome(substring)) {
                path.push(substring);
                backtrack(end + 1);
                path.pop();
            }
        }
    };

    backtrack(0);
    return result;
};