var countKReducibleNumbers = function(n, k) {
    const s = n.toString();
    const len = s.length;
    let ans = 0;

    function isKReducible(num, k) {
        if (num < k) return false;
        let sum = 0;
        let temp = num;
        while (temp > 0) {
            sum += temp % 10;
            temp = Math.floor(temp / 10);
        }
        return num % k === 0 && sum % k === 0;
    }

    function dfs(index, isLimit, num) {
        if (index === len) {
            if (isKReducible(num, k)) {
                return 1;
            } else {
                return 0;
            }
        }

        let up = isLimit ? parseInt(s[index]) : 9;
        let count = 0;
        for (let i = 0; i <= up; i++) {
            count += dfs(index + 1, isLimit && i === up, num * 10 + i);
        }
        return count;
    }

    return dfs(0, true, 0);
};