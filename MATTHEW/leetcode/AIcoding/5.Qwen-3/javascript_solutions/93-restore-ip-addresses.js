function restoreIpAddresses(s) {
    const result = [];
    const backtrack = (start, parts) => {
        if (parts.length === 4) {
            if (start === s.length) {
                result.push(parts.join('.'));
            }
            return;
        }
        for (let i = start; i < s.length; i++) {
            const num = s.substring(start, i + 1);
            if ((num.length > 1 && num[0] === '0') || parseInt(num, 10) > 255) break;
            backtrack(i + 1, [...parts, num]);
        }
    };
    backtrack(0, []);
    return result;
}