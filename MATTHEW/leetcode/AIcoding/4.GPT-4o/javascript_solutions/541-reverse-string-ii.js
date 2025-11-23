var reverseStr = function(s, k) {
    let result = '';
    for (let i = 0; i < s.length; i += 2 * k) {
        let part = s.slice(i, i + k).split('').reverse().join('');
        result += part + s.slice(i + k, i + 2 * k);
    }
    return result;
};