var divideString = function(s, k, fill) {
    const result = [];
    for (let i = 0; i < s.length; i += k) {
        let sub = s.substring(i, i + k);
        while (sub.length < k) {
            sub += fill;
        }
        result.push(sub);
    }
    return result;
};