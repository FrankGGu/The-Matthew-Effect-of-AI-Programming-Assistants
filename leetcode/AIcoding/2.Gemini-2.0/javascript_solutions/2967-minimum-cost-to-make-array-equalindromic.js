var minimumCost = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const median1 = nums[Math.floor((n - 1) / 2)];
    const median2 = nums[Math.floor(n / 2)];

    function cost(x) {
        let res = 0;
        for (let num of nums) {
            res += Math.abs(num - x);
        }
        return res;
    }

    function isPalindrome(x) {
        const s = String(x);
        let l = 0, r = s.length - 1;
        while (l < r) {
            if (s[l] !== s[r]) return false;
            l++;
            r--;
        }
        return true;
    }

    function findNearestPalindrome(x) {
        if (isPalindrome(x)) return x;

        const s = String(x);
        const n = s.length;
        const prefix = s.substring(0, Math.floor((n + 1) / 2));
        let palindrome = prefix + prefix.slice(0, n % 2 === 0 ? prefix.length : prefix.length - 1).split("").reverse().join("");

        if (Number(palindrome) >= x) {
            return Number(palindrome);
        }

        let num = Number(prefix);
        num--;
        if (num < 0) {
            if (n % 2 === 0) {
                return 9;
            } else {
                return 99;
            }
        }
        const newPrefix = String(num);
        palindrome = newPrefix + newPrefix.slice(0, n % 2 === 0 ? newPrefix.length : newPrefix.length - 1).split("").reverse().join("");
        return Number(palindrome);
    }

    let target1 = findNearestPalindrome(median1);
    let target2 = findNearestPalindrome(median2);

    let ans = cost(target1);
    if (target1 !== target2) {
        ans = Math.min(ans, cost(target2));
    }

    let lower = median1;
    while(!isPalindrome(lower)){
        lower--;
    }
    ans = Math.min(ans, cost(lower));

    let upper = median2;
    while(!isPalindrome(upper)){
        upper++;
    }
    ans = Math.min(ans, cost(upper));

    return ans;
};