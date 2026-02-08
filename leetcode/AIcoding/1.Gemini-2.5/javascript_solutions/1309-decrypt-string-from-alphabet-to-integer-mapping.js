var freqAlphabets = function(s) {
    let result = [];
    let i = s.length - 1;

    while (i >= 0) {
        if (s[i] === '#') {
            let numStr = s.substring(i - 2, i);
            let num = parseInt(numStr);
            result.push(String.fromCharCode(96 + num));
            i -= 3; 
        } else {
            let num = parseInt(s[i]);
            result.push(String.fromCharCode(96 + num));
            i -= 1; 
        }
    }

    return result.reverse().join('');
};