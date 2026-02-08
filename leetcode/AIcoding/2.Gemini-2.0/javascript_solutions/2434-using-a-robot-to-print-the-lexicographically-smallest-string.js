var robotWithString = function(s) {
    let n = s.length;
    let suffixMin = new Array(n);
    suffixMin[n - 1] = s[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        suffixMin[i] = s[i] < suffixMin[i + 1] ? s[i] : suffixMin[i + 1];
    }

    let stack = [];
    let result = "";
    for (let i = 0; i < n; i++) {
        stack.push(s[i]);
        while (stack.length > 0 && stack[stack.length - 1] <= suffixMin[i + 1 > n - 1 ? n - 1 : i + 1]) {
            result += stack.pop();
        }
    }

    while (stack.length > 0) {
        result += stack.pop();
    }

    return result;
};