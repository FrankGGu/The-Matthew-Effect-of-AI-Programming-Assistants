var minMovesToMakePalindrome = function(s) {
    let str = s.split("");
    let moves = 0;

    while (str.length > 0) {
        let lastIndex = str.lastIndexOf(str[0]);

        if (lastIndex === 0) {
            moves += Math.floor(str.length / 2);
            break;
        } else if (lastIndex === str.length - 1) {
            str.shift();
            str.pop();
        } else {
            moves += lastIndex;
            str.splice(lastIndex, 1);
            str.shift();
        }
    }

    return moves;
};