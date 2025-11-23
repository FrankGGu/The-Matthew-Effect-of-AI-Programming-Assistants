var addSpaces = function(s, spaces) {
    let result = [];
    let prev = 0;
    for (let i = 0; i < spaces.length; i++) {
        let current = spaces[i];
        result.push(s.substring(prev, current));
        prev = current;
    }
    result.push(s.substring(prev));
    return result.join(' ');
};