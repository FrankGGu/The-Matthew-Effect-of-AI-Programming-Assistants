var modifyString = function(s) {
    let result = s.split('');
    for (let i = 0; i < result.length; i++) {
        if (result[i] === '?') {
            for (let char = 0; char < 26; char++) {
                let replacement = String.fromCharCode('a'.charCodeAt(0) + char);
                if ((i === 0 || result[i - 1] !== replacement) && (i === result.length - 1 || result[i + 1] !== replacement)) {
                    result[i] = replacement;
                    break;
                }
            }
        }
    }
    return result.join('');
};