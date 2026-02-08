var minOperations = function(num1, num2) {
    let n = num1.length;
    let m = num2.length;
    let diff = Math.abs(n - m);
    let zeros = 0;
    for (let i = 0; i < diff; i++) {
        zeros += '0';
    }
    if (n < m) {
        num1 = zeros + num1;
    } else {
        num2 = zeros + num2;
    }

    let ans = 0;
    let current = 0;
    for (let i = 0; i < Math.max(n, m); i++) {
        if (num1[i] !== num2[i]) {
            if (current === 0) {
                current = parseInt(num2[i]) - parseInt(num1[i]);
                ans++;
            } else if (parseInt(num2[i]) - parseInt(num1[i]) === current) {
                continue;
            } else {
                ans++;
                current = parseInt(num2[i]) - parseInt(num1[i]);
            }
        } else if (current !== 0) {
            current = 0;
        }
    }

    return ans;
};