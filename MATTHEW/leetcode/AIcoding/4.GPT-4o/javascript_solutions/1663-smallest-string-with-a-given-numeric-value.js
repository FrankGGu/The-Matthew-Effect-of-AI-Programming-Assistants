var getSmallestString = function(n, k) {
    let result = [];
    k -= n; 
    for (let i = 0; i < n; i++) {
        let charValue = Math.min(26, k + 1);
        result.push(String.fromCharCode(97 + charValue - 1));
        k -= charValue - 1;
    }
    return result.join('');
};