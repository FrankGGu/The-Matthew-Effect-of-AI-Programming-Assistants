var modifyString = function(s) {
    let result = s.split('');
    for (let i = 0; i < result.length; i++) {
        if (result[i] === '?') {
            for (let char = 'a'; char <= 'c'; char = String.fromCharCode(char.charCodeAt(0) + 1)) {
                if ((i === 0 || result[i - 1] !== char) && (i === result.length - 1 || result[i + 1] !== char)) {
                    result[i] = char;
                    break;
                }
            }
        }
    }
    return result.join('');
};