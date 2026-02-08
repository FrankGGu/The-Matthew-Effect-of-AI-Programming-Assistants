var divideString = function(s, k, fill) {
    let result = [];
    for (let i = 0; i < s.length; i += k) {
        let chunk = s.substr(i, k);
        if (chunk.length < k) {
            chunk += fill.repeat(k - chunk.length);
        }
        result.push(chunk);
    }
    return result;
};