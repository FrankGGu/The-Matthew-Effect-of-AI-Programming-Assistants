var interpret = function(command) {
    let result = "";
    for (let i = 0; i < command.length; ) {
        if (command[i] === 'G') {
            result += 'G';
            i++;
        } else if (command[i] === '(' && command[i+1] === ')') {
            result += 'o';
            i += 2;
        } else if (command[i] === '(' && command[i+1] === 'a') { // implies (al)
            result += 'al';
            i += 4;
        }
    }
    return result;
};