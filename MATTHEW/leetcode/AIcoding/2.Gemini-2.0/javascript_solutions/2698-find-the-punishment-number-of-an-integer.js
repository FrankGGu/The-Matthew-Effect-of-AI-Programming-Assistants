var punishmentNumber = function(n) {
    let ans = 0;

    function check(str, target) {
        if (str.length === 0) {
            return target === 0;
        }

        for (let i = 1; i <= str.length; i++) {
            let num = parseInt(str.substring(0, i));
            if (check(str.substring(i), target - num)) {
                return true;
            }
        }

        return false;
    }

    for (let i = 1; i <= n; i++) {
        let square = i * i;
        let str = square.toString();
        if (check(str, i)) {
            ans += square;
        }
    }

    return ans;
};