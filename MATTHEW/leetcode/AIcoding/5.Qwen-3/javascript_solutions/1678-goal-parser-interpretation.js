function interpret(command) {
    let result = '';
    for (let i = 0; i < command.length; i++) {
        if (command[i] === '(') {
            if (command[i + 1] === ')') {
                result += 'o';
                i += 1;
            } else {
                result += 'a';
                while (command[i] !== ')') {
                    i++;
                }
            }
        } else if (command[i] === 'g') {
            result += 'g';
        }
    }
    return result;
}