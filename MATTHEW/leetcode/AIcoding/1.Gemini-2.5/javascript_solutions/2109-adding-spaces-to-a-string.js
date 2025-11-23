var addSpaces = function(s, spaces) {
    let result = [];
    let lastIndex = 0;

    for (let i = 0; i < spaces.length; i++) {
        let spacePos = spaces[i];
        result.push(s.substring(lastIndex, spacePos));
        result.push(' ');
        lastIndex = spacePos;
    }

    result.push(s.substring(lastIndex));

    return result.join('');
};