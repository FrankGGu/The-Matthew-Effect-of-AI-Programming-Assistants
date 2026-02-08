var splitString = function(s) {
    const n = s.length;
    for (let len = 1; len <= n / 2; len++) {
        let prev = BigInt(s.slice(0, len));
        let start = len;
        let result = true;

        while (start < n) {
            let next = prev - BigInt(1);
            const nextStr = next.toString();
            if (s.startsWith(nextStr, start)) {
                start += nextStr.length;
                prev = next;
            } else {
                result = false;
                break;
            }
        }

        if (result && start === n) {
            return true;
        }
    }
    return false;
};